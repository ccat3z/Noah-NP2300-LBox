/* qmsgbox for NP2300 */
#include <stdio.h>
#include <stdlib.h>
#include <qapplication.h>
#include <qmessagebox.h>
#include <qtextcodec.h>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	QTextCodec *codec = QTextCodec::codecForName("GB2312");
	a.setDefaultCodec(codec);
	QFont font = a.font();
	font.setPointSize(15);
	font.setFamily("noah");
	a.setFont(font);
	if (argc == 1)
		printf
		    ("Usage: %s [type] [[[button code 1 - 3] | [button text 1 - 3] [default button] [cancel button]] [title] [content]] [size]\n",
		     argv[0]);
	else if (atoi(argv[1]) == 1)
		printf("%d",
		       QMessageBox::information(NULL, QObject::tr(argv[5]),
						QObject::tr(argv[6]),
						atoi(argv[2]), atoi(argv[3]),
						atoi(argv[4])));
	else if (atoi(argv[1]) == 11)
		printf("%d",
		       QMessageBox::information(NULL, QObject::tr(argv[7]),
						QObject::tr(argv[8]),
						QObject::tr(argv[2]),
						QObject::tr(argv[3]),
						QObject::tr(argv[4]),
						atoi(argv[5]), atoi(argv[6])));
	else if (atoi(argv[1]) == 2)
		printf("%d",
		       QMessageBox::warning(NULL, QObject::tr(argv[5]),
					    QObject::tr(argv[6]), atoi(argv[2]),
					    atoi(argv[3]), atoi(argv[4])));
	else if (atoi(argv[1]) == 12)
		printf("%d",
		       QMessageBox::warning(NULL, QObject::tr(argv[7]),
					    QObject::tr(argv[8]),
					    QObject::tr(argv[2]),
					    QObject::tr(argv[3]),
					    QObject::tr(argv[4]), atoi(argv[5]),
					    atoi(argv[6])));
	else if (atoi(argv[1]) == 3)
		printf("%d",
		       QMessageBox::critical(NULL, QObject::tr(argv[5]),
					     QObject::tr(argv[6]),
					     atoi(argv[2]), atoi(argv[3]),
					     atoi(argv[4])));
	else if (atoi(argv[1]) == 13)
		printf("%d",
		       QMessageBox::critical(NULL, QObject::tr(argv[7]),
					     QObject::tr(argv[8]),
					     QObject::tr(argv[2]),
					     QObject::tr(argv[3]),
					     QObject::tr(argv[4]),
					     atoi(argv[5]), atoi(argv[6])));
	else if (atoi(argv[1]) == 4)
		QMessageBox::about(NULL, QObject::tr(argv[2]),
				   QObject::tr(argv[3]));
	else if (atoi(argv[1]) == 5)
		QMessageBox::aboutQt(NULL);
	return 0;
}
