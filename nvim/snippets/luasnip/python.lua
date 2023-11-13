return {
    s({trig="imagen"}, {
        t("self."), i(1), t({" = QLabel(self)", ""}),
        t("self."), recuperar(2, 1), t({".setGeometry(50, 50, 200, 200)", ""}),
        t({"ruta_imagen = path.join()", ""}),  
        t({"pix = QPixmap(ruta_imagen)", ""}),
        t("self."), recuperar(3, 1), t({".setPixmap(pix)", ""}), 
        t("self."), recuperar(4, 1), t({".setScaledContents(True)", ""}), 
    }),
    s({trig="texto"}, {
        t("self."), i(1), t(" = QLabel("), i(3), t({", self)", ""}),
        t("self."), recuperar(2, 1), t(".move()")
    }),
    s({trig="input"}, {
        t("self."), i(1), t(" = QLineEdit("), i(3), t({", self)", ""}),
        t("self."), recuperar(2, 1), t(".setGeometry()")
    }),
    s({trig="boton"}, {
        t("self."), i(1), t(" = QPushButton(\'&"), i(5), t({"\', self)", ""}),
        t("self."), recuperar(2, 1), t(".resize(self."), recuperar(4, 1), t({".sizeHint())", ""}) ,
        t("self."), recuperar(3, 1), t(".move()")
    }),
    s({trig="hbox"}, {
        i(1), t({" = QHBoxLayout()", ""}),
        recuperar(2, 1), t({".addStretch(1)", ""}),
        recuperar(3, 1), t({".addWidget()", ""}),
        recuperar(4, 1), t({".addLayout()", ""}),
        t("#  self.setLayout(mi_layout)")
    }),
    s({trig="vbox"}, {
        i(1), t({" = QVBoxLayout()", ""}),
        recuperar(2, 1), t({".addStretch(1)", ""}),
        recuperar(3, 1), t({".addWidget()", ""}),
        recuperar(4, 1), t({".addLayout()", ""}),
        t("#  self.setLayout(mi_layout)")
    }),
}
