import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import ExpyTableView
import Kingfisher

class MenuVC: BaseVC {
    let viewModel = MenuViewModel()
    private let viewAppear = PublishRelay<Void>()
    private var expyTableViewState = TableState()
    private let proFilButton = ProFilButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "MenuBackGround")
    }
    private let introduceView = IntroduceView().then {
        $0.backgroundColor = .white
    }
    private let backView = UIView().then {
        $0.backgroundColor = .init(named: "MenuBackGround")
    }
    private let editTableView = ExpyTableView().then {
        $0.register(EditTableViewCell.self, forCellReuseIdentifier: "EditTableViewCell")
        $0.rowHeight = 52
        $0.separatorStyle = .none
    }

    override func configureVC() {
        editTableView.delegate = self
        editTableView.dataSource = self
        proFilButton.rx.tap.subscribe(onNext: {
            let vc = MyPageVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewAppear.accept(())
    }
    
    override func bind() {
        let input = MenuViewModel.Input(viewAppear: viewAppear.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.myPage.subscribe(onNext: { [self] in
            proFilButton.studentNameLabel.text = $0.name
            proFilButton.subTitleLabel.text = "\($0.grade)학년 \($0.class_num)반 \($0.number)번"
            if $0.profile_image_url != nil {
                let url = URL(string: $0.profile_image_url ?? "")
                proFilButton.studentImageView.kf.setImage(with: url)
            }
            introduceView.proFilLabel.text = $0.introduce
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            proFilButton,
            introduceView
        ].forEach { backView.addSubview($0)}
        [
            backView,
            editTableView
        ].forEach { view.addSubview($0) }
        
    }

    override func setLayout() {
        backView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(273)
        }
        proFilButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(105)
        }
        introduceView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(108)
            $0.top.equalTo(proFilButton.snp.bottom)
        }
        editTableView.snp.makeConstraints {
            $0.top.equalTo(introduceView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}

extension MenuVC: ExpyTableViewDelegate, ExpyTableViewDataSource {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        return
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = EditTableViewCell()
        cell.selectionStyle = .none
        cell.titleLabel.text = expyTableViewState.tableTitle[section]
        cell.editImageView.image = UIImage(named: expyTableViewState.tableImage[section])
        cell.chevronImageView.image = UIImage(systemName: "chevron.down")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expyTableViewState.tableSubTitlt[section].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as! EditTableViewCell
        if indexPath.row != 0 {
            cell.titleLabel.text = expyTableViewState.tableSubTitlt[indexPath.section][indexPath.row - 1]
            cell.editImageView.image = UIImage(named: expyTableViewState.tableSubImage[indexPath.section][indexPath.row - 1])
        }
        cell.backgroundColor = .init(named: "MenuBackGround")
        cell.chevronImageView.image = .init(named: "")
        cell.layer.cornerRadius = 8
        if indexPath.row == expyTableViewState.tableSubTitlt[indexPath.section].count {
            cell.bottomLineView.backgroundColor = .white
        } else {
            cell.bottomLineView.backgroundColor = .init(named: "PickerLine")
        }
        cell.editImageView.snp.updateConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().inset(16)
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EditTableViewCell
        if indexPath.row == 0 {
            if expyTableViewState.tableState[indexPath.section] {
                cell.chevronImageView.image = UIImage(systemName: "chevron.down")
                expyTableViewState.tableState[indexPath.section] = false
            } else {
                cell.chevronImageView.image = UIImage(systemName: "chevron.right")
                expyTableViewState.tableState[indexPath.section] = true
            }
        } else {
            print(cell.titleLabel.text!)
        }
    }
    
}
