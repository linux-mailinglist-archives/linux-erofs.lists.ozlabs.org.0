Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BF9ABAEA
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2024 03:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729646306;
	bh=koYPSpez+tWorz652Epwoi68yVa8+LqLKejqNQFRMA4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=l3mLv1mrGTXEPYuDHggc8v4OZd0SqR8/R2R/J7PN2NFVRX/UfE7focwwc4AermyDb
	 DM8iz1tCKk16cV1j8tHWeFkqaGUnQ7aQo69q7pbZfksPXctBS+dgRpVurY/YrxWS1r
	 guPYsMUQkSiKxNMD4w0slPpGzIdIgg9DY7muMRDr7olUPXryK5N6x4ByT1Diu4GZNc
	 uksK3X46TVAf6gX40fDdrms20iQ0PnAmRFpWrDoXJjsUmzkBzY9jWOk37nhTZKuYbF
	 JNTxf03Yt/h4OmsllhTOZ/hegn2qQhVXeK1j9TZ2MV2zmOIGpjrKd6AtEJph1Gb3Zp
	 83zbcRFixrCyg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYB4y3r70z2ydW
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2024 12:18:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.245.195.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729646304;
	cv=none; b=RevxDSzhUfzujdXcKn9KzxOLXu+fTlwXDlKxiU8AfdvqZNZGo3YYXDgMx9mrFRIAL6UFa3XepdG6B8wk99JPuweY/7FMN76os55wfiiSdvWeXTOV0abf0a/V1xALQrpouKFznTAPeEUrl+uv2w+C3tL3wLgh/Q6POfiej7hesjGG2vZlK4rl/KNoTurRW/bVfbcSrh21UgM8tnyJNh4R/7O87FmydgOHUmGiOmixo3X0MtBimKFTXrFP+rlynZE87SE+Vt6mufqBOGygDqERFJwLlaH5TgAm8hUyzihjAJfu8z9xznBdB2JLxUfwy9WcWjRNyRJ9Ig1hmss4uavjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729646304; c=relaxed/relaxed;
	bh=koYPSpez+tWorz652Epwoi68yVa8+LqLKejqNQFRMA4=;
	h=Message-ID:MIME-Version:From:To:Date:Subject:Content-Type; b=PDapuOkCq3GPfUvewp4ZdhHToVjcWJqEpMdQQc7/7cY9TQkDTaQS0J3oweMWHGCtC8tmvLocY4zDF8On2OkckWAc4newzWq6NJglo5hAeBm3D7qnQxq6rRymirlNLQ+KcH/358DLc4/f6XYN4wGvdwPph4Xc41Ylukkg4pAjx7VfMzyBb7La856N/NkqHB5cN36hlFc1X6Ju2vIt5h50F797qfnXo3c1CYH1fjkQOhy6fBaJsjpaQqGGvUfQPAqCE6KNV7E39AOryuWAEmZxRxfQM9ksmfpiQuYDNCdpGZWV39FFKrjwbS9u5tgQOWlnWKPrqvqkgD051Qwzd/OZYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=epoxyresinfactory.com; dkim=pass (1024-bit key; unprotected) header.d=de.adhesivecustom.com header.i=@de.adhesivecustom.com header.a=rsa-sha256 header.s=aliyun-eu-central-1 header.b=YwoMKJSt; dkim-atps=neutral; spf=pass (client-ip=47.245.195.137; helo=static195-137.de.dm.aliyun.com; envelope-from=unique@de.adhesivecustom.com; receiver=lists.ozlabs.org) smtp.mailfrom=de.adhesivecustom.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=epoxyresinfactory.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=de.adhesivecustom.com header.i=@de.adhesivecustom.com header.a=rsa-sha256 header.s=aliyun-eu-central-1 header.b=YwoMKJSt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=de.adhesivecustom.com (client-ip=47.245.195.137; helo=static195-137.de.dm.aliyun.com; envelope-from=unique@de.adhesivecustom.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 338 seconds by postgrey-1.37 at boromir; Wed, 23 Oct 2024 12:18:19 AEDT
Received: from static195-137.de.dm.aliyun.com (static195-137.de.dm.aliyun.com [47.245.195.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYB4q1Rn5z2xfR
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2024 12:18:16 +1100 (AEDT)
X-AliDM-RcptTo: bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw==
Feedback-ID: default:unique@de.adhesivecustom.com:batch:33972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=de.adhesivecustom.com; s=aliyun-eu-central-1;
	t=1729646294; h=Message-ID:MIME-Version:From:To:Date:Subject:Content-Type;
	bh=koYPSpez+tWorz652Epwoi68yVa8+LqLKejqNQFRMA4=;
	b=YwoMKJStjmdXnqQE0VeAIXIzX5E5u0FCv0i1NC5hM3+um7gthW+vY8SCw7N4fSP77UzD6BtvWYq/mD7adEhZUIlTVf9FVj6KrlDFLCamkob3fQSDDqW41kQlmH4dItXD1HMUDpFTgwlj5yCElgFYerajrLDO3Vzd/sJHuK3j2lw=
Received: from DESKTOP-CVOR0HJ(mailfrom:Unique@de.adhesivecustom.com fp:SMTPD_-----4rt99H cluster:dm-ay35de-a)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Oct 2024 09:12:28 +0800
X-EnvId: 7380185817
Message-ID: <20241023091223336.sale04@epoxyresinfactory.com>
MIME-Version: 1.0
To: "Linux-erofs" <linux-erofs@lists.ozlabs.org>
Date: 23 Oct 2024 09:12:25 +0800
Subject: =?utf-8?B?RHVhbCBjdXJpbmcgVVYgJiA0MDDCsEMgaGVhdCByZXNpc3Rh?=
 =?utf-8?B?bmN0IHNpbGljb25l?=
Content-Type: multipart/alternative;
 boundary=--boundary_2038_e2dfd44f-e10a-44db-802a-43f9f735f915
X-Spam-Status: No, score=2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	UNPARSEABLE_RELAY,URIBL_DBL_SPAM,URI_HEX autolearn=disabled
	version=4.0.0
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Krystal Qiu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: sale04@epoxyresinfactory.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


----boundary_2038_e2dfd44f-e10a-44db-802a-43f9f735f915
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello ,=0D=0A=0D=0A=0D=0AHere share with you some successful case=
s about our UV, Epoxy, Polyurethane and Silicone Adhesive:=0D=0A=0D=0A=
1.UV Adhesive-ZDS3504A for pin fixing=EF=BC=8Cdual curing, fast c=
uring and good adhesion=0D=0A=0D=0A2.Epoxy Adhesive- ZDS263AB for=
 electronics potting, high and low temperature resistant and ther=
mal conductivity=0D=0A=0D=0A3.Polyurethane Adhesive-ZDS205 for ch=
ips dispensing, good flexibility, great adhesion, fast curing=0D=0A=
=0D=0A4.Silicone Adhesive-ZDSDB695 for wire sealing, 400=C2=B0C h=
eat resistance for long time, fast curing=0D=0A=0D=0ABeside these=
 adhesives, we also have the complete chemicals like the thermall=
y conductive silicone,peelable UV=EF=BC=8CV0 clear PU &amp; heat =
resistant epoxy for Energy Storage=EF=BC=8C Automotive Assembly P=
roduction, Electronic Components,Robot Assembly Production, Batte=
ry Pack and etc.,=0D=0AWelcome to send the requirements then we w=
ill provide the best solution to you.=0D=0A=0D=0AAnd one more thi=
ng, we have the booth at Electronica China in from 14th to 16th O=
ct in Shenzhen, welcome to visit us.=0D=0A=0D=0A=0D=0A-----------=
-- =0D=0A=0D=0AKrystal Qiu=E2=94=82Sales Director=0D=0A =0D=0AShe=
nzhen Zhengdasheng Chemical Co.Ltd.=0D=0AMobile/WhatsApp: +86 181=
94019303T: 86-755-84875752=0D=0AF: 86-755-84875750=0D=0AW: www.ep=
oxyresinfactory.comW:www.zdschemical.com=0D=0A=0D=0AA: 4th floor =
, Longyuntong Building, No. 164-5 Pengda Road, =0D=0ALonggang Dis=
trict, Shenzhen,China.
----boundary_2038_e2dfd44f-e10a-44db-802a-43f9f735f915
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML>=0A<html><head><meta HTTP-EQUIV=3D"Content-Type" C=
ONTENT=3D"text/html; charset=3DUTF-8"/>=0D=0A                    =
                  <title>Dual curing UV & 400=C2=B0C heat resista=
nct silicone</title></head><body><SPAN style=3D"FONT-SIZE: 13px">=
<SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.=
5"><SPAN style=3D"COLOR: #a41ad4"><SPAN style=3D"COLOR: #000000">=
Hello ,</SPAN></SPAN></SPAN></SPAN></SPAN><BR type=3D"_moz">=0D=0A=
<DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FO=
NT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D=
"COLOR: #a41ad4">&nbsp;</SPAN></SPAN></SPAN></SPAN></DIV>=0D=0A<D=
IV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: ar=
ial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41a=
d4"><SPAN style=3D"COLOR: #000000">Here share with you some succe=
ssful cases about our <U><EM><STRONG>UV, Epoxy, Polyurethane and =
Silicone Adhesive</STRONG></EM></U>:</SPAN></SPAN></SPAN></SPAN><=
/SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE=
: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HE=
IGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4">&nbsp;</SPAN></SPAN></S=
PAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT=
-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D"LI=
NE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4"><SPAN style=3D"COL=
OR: #000000"><STRONG>1.UV Adhesive-ZDS3504A f</STRONG>or pin fixi=
ng=EF=BC=8Cdual curing, fast curing and good adhesion</SPAN></SPA=
N></SPAN></SPAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN s=
tyle=3D"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN=
 style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4">&nbsp;=
</SPAN></SPAN></SPAN></SPAN><IMG style=3D"HEIGHT: 486px; WIDTH: 3=
17px" src=3D"https://trade-1306369054.file.myqcloud.com/edm/22689=
/20241010/Q3heZL5ti3n3JM7d/image-20241010172902-2.png?sign=3Dq-si=
gn-algorithm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ=
%26q-sign-time%3D1728553431%3B1760089431%26q-key-time%3D172855343=
1%3B1760089431%26q-header-list%3D%26q-url-param-list%3D%26q-signa=
ture%3De5bf18ab61a24bce78a083f945d781ea8c5f4387" width=3D317 heig=
ht=3D486 data-cke-saved-src=3D"https://trade-1306369054.file.myqc=
loud.com/edm/22689/20241010/Q3heZL5ti3n3JM7d/image-20241010172902=
-2.png?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWM=
xHL7cqnUu2tUoxvfAQ%26q-sign-time%3D1728553431%3B1760089431%26q-ke=
y-time%3D1728553431%3B1760089431%26q-header-list%3D%26q-url-param=
-list%3D%26q-signature%3De5bf18ab61a24bce78a083f945d781ea8c5f4387=
" data-code=3D"edm/22689/20241010/Q3heZL5ti3n3JM7d/image-20241010=
172902-2.png"><BR><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"=
FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D=
"COLOR: #a41ad4"></SPAN></SPAN></SPAN></SPAN><BR type=3D"_moz"></=
DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FON=
T-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"=
COLOR: #a41ad4"><SPAN style=3D"COLOR: #000000"><STRONG>2.Epoxy Ad=
hesive- ZDS263AB </STRONG>for electronics potting, high and low t=
emperature resistant and thermal conductivity</SPAN></SPAN></SPAN=
></SPAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"=
FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D=
"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4">&nbsp;</SPAN></=
SPAN></SPAN></SPAN><IMG style=3D"HEIGHT: 487px; WIDTH: 318px" src=
=3D"https://trade-1306369054.file.myqcloud.com/edm/22689/20241010=
/s6yoRlsAmCbQYJN7/image-20241010172918-3.png?sign=3Dq-sign-algori=
thm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ%26q-sign=
-time%3D1728553431%3B1760089431%26q-key-time%3D1728553431%3B17600=
89431%26q-header-list%3D%26q-url-param-list%3D%26q-signature%3D75=
c4e30fb26fc98a82a566671456a5ee26daa6cb" width=3D318 height=3D487 =
data-cke-saved-src=3D"https://trade-1306369054.file.myqcloud.com/=
edm/22689/20241010/s6yoRlsAmCbQYJN7/image-20241010172918-3.png?si=
gn=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL7cqnUu=
2tUoxvfAQ%26q-sign-time%3D1728553431%3B1760089431%26q-key-time%3D=
1728553431%3B1760089431%26q-header-list%3D%26q-url-param-list%3D%=
26q-signature%3D75c4e30fb26fc98a82a566671456a5ee26daa6cb" data-co=
de=3D"edm/22689/20241010/s6yoRlsAmCbQYJN7/image-20241010172918-3.=
png"><BR><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMI=
LY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR:=
 #a41ad4"></SPAN></SPAN></SPAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A=
<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: =
arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a4=
1ad4"><SPAN style=3D"COLOR: #000000"><STRONG>3.Polyurethane Adhes=
ive-ZDS205 </STRONG>for chips dispensing, good flexibility, great=
 adhesion, fast curing</SPAN></SPAN></SPAN></SPAN></SPAN><BR type=
=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN =
style=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SP=
AN style=3D"COLOR: #a41ad4">&nbsp;</SPAN></SPAN></SPAN></SPAN><IM=
G style=3D"HEIGHT: 257px; WIDTH: 463px" src=3D"https://trade-1306=
369054.file.myqcloud.com/edm/22689/20241010/EUf1NZ9yXBcvciTT/imag=
e-20241010172932-4.png?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAK=
IDFJ7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ%26q-sign-time%3D1728553432%3B1=
760089432%26q-key-time%3D1728553432%3B1760089432%26q-header-list%=
3D%26q-url-param-list%3D%26q-signature%3D82d0bfc0b03f3721b45b3454=
0e9834f1b549dc5d" width=3D463 height=3D257 data-cke-saved-src=3D"=
https://trade-1306369054.file.myqcloud.com/edm/22689/20241010/EUf=
1NZ9yXBcvciTT/image-20241010172932-4.png?sign=3Dq-sign-algorithm%=
3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ%26q-sign-tim=
e%3D1728553432%3B1760089432%26q-key-time%3D1728553432%3B176008943=
2%26q-header-list%3D%26q-url-param-list%3D%26q-signature%3D82d0bf=
c0b03f3721b45b34540e9834f1b549dc5d" data-code=3D"edm/22689/202410=
10/EUf1NZ9yXBcvciTT/image-20241010172932-4.png"><BR><SPAN style=3D=
"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D=
"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4"></SPAN></SPAN><=
/SPAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FO=
NT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D"=
LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4"><SPAN style=3D"C=
OLOR: #000000"><STRONG>4.Silicone Adhesive-ZDSDB695 </STRONG>for =
wire sealing, 400=C2=B0C heat resistance for long time, fast curi=
ng</SPAN></SPAN></SPAN></SPAN></SPAN><BR type=3D"_moz"></DIV>=0D=0A=
<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D"FONT-FAMILY: =
arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a4=
1ad4">&nbsp;</SPAN></SPAN></SPAN></SPAN><IMG style=3D"HEIGHT: 509=
px; WIDTH: 331px" src=3D"https://trade-1306369054.file.myqcloud.c=
om/edm/22689/20241010/JSI6b5ZfbhTxB8mI/image-20241010172949-5.png=
?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL7cq=
nUu2tUoxvfAQ%26q-sign-time%3D1728553432%3B1760089432%26q-key-time=
%3D1728553432%3B1760089432%26q-header-list%3D%26q-url-param-list%=
3D%26q-signature%3D62f63c3e7009e2918bfbb60062157399f9c7bae9" widt=
h=3D331 height=3D509 data-cke-saved-src=3D"https://trade-13063690=
54.file.myqcloud.com/edm/22689/20241010/JSI6b5ZfbhTxB8mI/image-20=
241010172949-5.png?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAKIDFJ=
7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ%26q-sign-time%3D1728553432%3B17600=
89432%26q-key-time%3D1728553432%3B1760089432%26q-header-list%3D%2=
6q-url-param-list%3D%26q-signature%3D62f63c3e7009e2918bfbb6006215=
7399f9c7bae9" data-code=3D"edm/22689/20241010/JSI6b5ZfbhTxB8mI/im=
age-20241010172949-5.png"><BR><SPAN style=3D"FONT-SIZE: 13px"><SP=
AN style=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5">=
<SPAN style=3D"COLOR: #a41ad4"></SPAN></SPAN></SPAN></SPAN><BR ty=
pe=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPA=
N style=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><=
SPAN style=3D"COLOR: #a41ad4"><SPAN style=3D"COLOR: #000000">Besi=
de these adhesives, we also have the complete chemicals like the =
<SPAN style=3D"TEXT-DECORATION: underline"><EM><STRONG>thermally =
conductive silicone,peelable UV=EF=BC=8CV0 clear PU &amp; heat re=
sistant epoxy</STRONG></EM></SPAN> for Energy Storage=EF=BC=8C Au=
tomotive Assembly Production, Electronic Components,Robot Assembl=
y Production, Battery Pack and etc.,<BR></SPAN></SPAN></SPAN></SP=
AN></SPAN><BR type=3D"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT-=
SIZE: 13px"><SPAN style=3D"FONT-FAMILY: arial"><SPAN style=3D"LIN=
E-HEIGHT: 1.5"><SPAN style=3D"COLOR: #a41ad4"><SPAN style=3D"COLO=
R: #000000">Welcome to send the requirements then we will provide=
 the best solution to you.&nbsp;</SPAN></SPAN></SPAN></SPAN></SPA=
N></DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN style=3D=
"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=
=3D"COLOR: #a41ad4">&nbsp;</SPAN></SPAN></SPAN></SPAN><BR type=3D=
"_moz"></DIV>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: 13px"><SPAN sty=
le=3D"FONT-FAMILY: arial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN =
style=3D"COLOR: #a41ad4"><SPAN style=3D"COLOR: #000000">And one m=
ore thing, we have the booth at Electronica China in from 14th to=
 16th Oct in Shenzhen, welcome to visit us.&nbsp;</SPAN></SPAN></=
SPAN></SPAN></SPAN></DIV></DIV>=0D=0A<DIV><IMG style=3D"HEIGHT: 7=
59px; WIDTH: 427px" src=3D"https://trade-1306369054.file.myqcloud=
.com/edm/22689/20241010/44UFxLVavVNyIJCf/image-20241010172741-1.j=
peg?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAKIDFJ7fxyjDQM1PWMxHL=
7cqnUu2tUoxvfAQ%26q-sign-time%3D1728553432%3B1760089432%26q-key-t=
ime%3D1728553432%3B1760089432%26q-header-list%3D%26q-url-param-li=
st%3D%26q-signature%3D5cafaf1239b58b6b5b146f92637c0c53d9e32e26" w=
idth=3D427 height=3D759 data-cke-saved-src=3D"https://trade-13063=
69054.file.myqcloud.com/edm/22689/20241010/44UFxLVavVNyIJCf/image=
-20241010172741-1.jpeg?sign=3Dq-sign-algorithm%3Dsha1%26q-ak%3DAK=
IDFJ7fxyjDQM1PWMxHL7cqnUu2tUoxvfAQ%26q-sign-time%3D1728553432%3B1=
760089432%26q-key-time%3D1728553432%3B1760089432%26q-header-list%=
3D%26q-url-param-list%3D%26q-signature%3D5cafaf1239b58b6b5b146f92=
637c0c53d9e32e26" data-code=3D"edm/22689/20241010/44UFxLVavVNyIJC=
f/image-20241010172741-1.jpeg"><BR><BR type=3D"_moz"></DIV>=0D=0A=
<DIV class=3Dmail-signature>=0D=0A<DIV><SPAN style=3D"FONT-SIZE: =
16px"><SPAN style=3D"LINE-HEIGHT: 18px">-------------</SPAN></SPA=
N> =0D=0A<DIV style=3D"TEXT-INDENT: 0px; -webkit-text-stroke-widt=
h: 0px">=0D=0A<DIV><SPAN style=3D"WHITE-SPACE: normal"><SPAN styl=
e=3D"WHITE-SPACE: normal"><SPAN style=3D"COLOR: #000033"><SPAN st=
yle=3D"FONT-SIZE: 14px"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN st=
yle=3D"FONT-FAMILY: lucida Grande, Verdana, Microsoft YaHei"><SPA=
N style=3D"FONT-STYLE: normal"><SPAN style=3D"font-variant-ligatu=
res: normal"><SPAN style=3D"font-variant-caps: normal"><SPAN styl=
e=3D"FONT-WEIGHT: 400"><SPAN style=3D"LETTER-SPACING: normal"><SP=
AN style=3D"ORPHANS: 2"><SPAN style=3D"TEXT-TRANSFORM: none"><SPA=
N style=3D"WHITE-SPACE: normal"><SPAN style=3D"WIDOWS: 2"><SPAN s=
tyle=3D"WORD-SPACING: 0px"><SPAN style=3D"text-decoration-style: =
initial"><SPAN style=3D"text-decoration-color: initial"><SPAN sty=
le=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"FONT-SIZE: small"><SPAN st=
yle=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"BACKGROUND-COLOR: #ffffff=
"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN style=3D"LINE-HEIGHT: =
1.5">Krystal Qiu&nbsp;</SPAN></SPAN><SPAN style=3D"FONT-FAMILY: a=
rial">=E2=94=82</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><=
/SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></S=
PAN></SPAN></SPAN></SPAN><SPAN style=3D"FONT-SIZE: 12px"><SPAN st=
yle=3D"FONT-FAMILY: arial">Sales Director</SPAN></SPAN></SPAN></S=
PAN></SPAN></DIV>=0D=0A<DIV><SPAN style=3D"WHITE-SPACE: normal"><=
SPAN style=3D"WHITE-SPACE: normal">&nbsp; <IMG class=3DimgIndex4 =
style=3D"HEIGHT: 50px; WIDTH: 167px" src=3D"https://cowork-storag=
e-public-cdn.lx.netease.com/lxbg/2023/11/27/ef8301efb8ee4962af8d6=
69d3c4ffde3.png" data-cke-saved-src=3D"https://cowork-storage-pub=
lic-cdn.lx.netease.com/lxbg/2023/11/27/ef8301efb8ee4962af8d669d3c=
4ffde3.png" data-timedate=3D"1701069330397"></SPAN></SPAN></DIV>=0D=0A=
<DIV><SPAN style=3D"WHITE-SPACE: normal"><SPAN style=3D"WHITE-SPA=
CE: normal"><SPAN style=3D"COLOR: #000033"><SPAN style=3D"FONT-SI=
ZE: 14px"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"FONT-FA=
MILY: lucida Grande, Verdana, Microsoft YaHei"><SPAN style=3D"FON=
T-STYLE: normal"><SPAN style=3D"font-variant-ligatures: normal"><=
SPAN style=3D"font-variant-caps: normal"><SPAN style=3D"FONT-WEIG=
HT: 400"><SPAN style=3D"LETTER-SPACING: normal"><SPAN style=3D"OR=
PHANS: 2"><SPAN style=3D"TEXT-TRANSFORM: none"><SPAN style=3D"WHI=
TE-SPACE: normal"><SPAN style=3D"WIDOWS: 2"><SPAN style=3D"WORD-S=
PACING: 0px"><SPAN style=3D"text-decoration-style: initial"><SPAN=
 style=3D"text-decoration-color: initial"><SPAN style=3D"LINE-HEI=
GHT: 1.5"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN style=3D"FONT-=
SIZE: small"><SPAN style=3D"LINE-HEIGHT: 1.5"><STRONG style=3D"BA=
CKGROUND-COLOR: #ffffff">Shenzhen Zhengdasheng Chemical Co.Ltd.</=
STRONG></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></DIV>=0D=0A<DIV><SPAN style=3D"WH=
ITE-SPACE: normal"><SPAN style=3D"WHITE-SPACE: normal"><SPAN styl=
e=3D"COLOR: #000033"><SPAN style=3D"FONT-SIZE: 14px"><SPAN style=3D=
"LINE-HEIGHT: 1.5"><SPAN style=3D"FONT-FAMILY: lucida Grande, Ver=
dana, Microsoft YaHei"><SPAN style=3D"FONT-STYLE: normal"><SPAN s=
tyle=3D"font-variant-ligatures: normal"><SPAN style=3D"font-varia=
nt-caps: normal"><SPAN style=3D"FONT-WEIGHT: 400"><SPAN style=3D"=
LETTER-SPACING: normal"><SPAN style=3D"ORPHANS: 2"><SPAN style=3D=
"TEXT-TRANSFORM: none"><SPAN style=3D"WHITE-SPACE: normal"><SPAN =
style=3D"WIDOWS: 2"><SPAN style=3D"WORD-SPACING: 0px"><SPAN style=
=3D"text-decoration-style: initial"><SPAN style=3D"text-decoratio=
n-color: initial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D=
"FONT-FAMILY: Arial"><SPAN style=3D"FONT-SIZE: small"><SPAN style=
=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"BACKGROUND-COLOR: #ffffff">M=
obile/WhatsApp: +86 18194019303</SPAN></SPAN></SPAN></SPAN></SPAN=
></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><=
/SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><BR><SPAN style=3D=
"COLOR: #000033"><SPAN style=3D"FONT-SIZE: 14px"><SPAN style=3D"L=
INE-HEIGHT: 1.5"><SPAN style=3D"FONT-FAMILY: lucida Grande, Verda=
na, Microsoft YaHei"><SPAN style=3D"FONT-STYLE: normal"><SPAN sty=
le=3D"font-variant-ligatures: normal"><SPAN style=3D"font-variant=
-caps: normal"><SPAN style=3D"FONT-WEIGHT: 400"><SPAN style=3D"LE=
TTER-SPACING: normal"><SPAN style=3D"ORPHANS: 2"><SPAN style=3D"T=
EXT-TRANSFORM: none"><SPAN style=3D"WHITE-SPACE: normal"><SPAN st=
yle=3D"WIDOWS: 2"><SPAN style=3D"WORD-SPACING: 0px"><SPAN style=3D=
"text-decoration-style: initial"><SPAN style=3D"text-decoration-c=
olor: initial"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"FO=
NT-FAMILY: Arial"><SPAN style=3D"FONT-SIZE: small"><SPAN style=3D=
"LINE-HEIGHT: 1.5"><SPAN style=3D"BACKGROUND-COLOR: #ffffff">T: 8=
6-755-84875752</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></DIV>=0D=0A<DIV><SP=
AN style=3D"WHITE-SPACE: normal"><SPAN style=3D"WHITE-SPACE: norm=
al"><SPAN style=3D"COLOR: #000033"><SPAN style=3D"FONT-SIZE: 14px=
"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"FONT-FAMILY: lu=
cida Grande, Verdana, Microsoft YaHei"><SPAN style=3D"FONT-STYLE:=
 normal"><SPAN style=3D"font-variant-ligatures: normal"><SPAN sty=
le=3D"font-variant-caps: normal"><SPAN style=3D"FONT-WEIGHT: 400"=
><SPAN style=3D"LETTER-SPACING: normal"><SPAN style=3D"ORPHANS: 2=
"><SPAN style=3D"TEXT-TRANSFORM: none"><SPAN style=3D"WHITE-SPACE=
: normal"><SPAN style=3D"WIDOWS: 2"><SPAN style=3D"WORD-SPACING: =
0px"><SPAN style=3D"text-decoration-style: initial"><SPAN style=3D=
"text-decoration-color: initial"><SPAN style=3D"LINE-HEIGHT: 1.5"=
><SPAN style=3D"FONT-FAMILY: Arial"><SPAN style=3D"FONT-SIZE: sma=
ll"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"BACKGROUND-CO=
LOR: #ffffff">F: 86-755-84875750</SPAN></SPAN></SPAN></SPAN></SPA=
N></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN>=
</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
DIV>=0D=0A<DIV><SPAN style=3D"WHITE-SPACE: normal"><SPAN style=3D=
"WHITE-SPACE: normal"><SPAN style=3D"COLOR: #000033"><SPAN style=3D=
"FONT-SIZE: 14px"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D=
"FONT-FAMILY: lucida Grande, Verdana, Microsoft YaHei"><SPAN styl=
e=3D"FONT-STYLE: normal"><SPAN style=3D"font-variant-ligatures: n=
ormal"><SPAN style=3D"font-variant-caps: normal"><SPAN style=3D"F=
ONT-WEIGHT: 400"><SPAN style=3D"LETTER-SPACING: normal"><SPAN sty=
le=3D"ORPHANS: 2"><SPAN style=3D"TEXT-TRANSFORM: none"><SPAN styl=
e=3D"WHITE-SPACE: normal"><SPAN style=3D"WIDOWS: 2"><SPAN style=3D=
"WORD-SPACING: 0px"><SPAN style=3D"text-decoration-style: initial=
"><SPAN style=3D"text-decoration-color: initial"><SPAN style=3D"L=
INE-HEIGHT: 1.5"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN style=3D=
"FONT-SIZE: small"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN style=3D=
"BACKGROUND-COLOR: #ffffff">W: <A style=3D"CURSOR: pointer; TEXT-=
DECORATION: none; COLOR: " href=3D"http://www.epoxyresinfactory.c=
om" rel=3Dnoopener target=3D_blank>www.epoxyresinfactory.com</A><=
BR>W:<A style=3D"CURSOR: pointer; TEXT-DECORATION: none; COLOR: "=
 href=3D"http://www.zdschemical.com" rel=3Dnoopener target=3D_bla=
nk>www.zdschemical.com</A></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN=
></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></DIV></=
DIV>=0D=0A<DIV style=3D"TEXT-INDENT: 0px; -webkit-text-stroke-wid=
th: 0px">=0D=0A<DIV><SPAN style=3D"WHITE-SPACE: normal"><SPAN sty=
le=3D"WHITE-SPACE: normal"><SPAN style=3D"COLOR: #000033"><SPAN s=
tyle=3D"FONT-SIZE: 14px"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPAN s=
tyle=3D"FONT-FAMILY: lucida Grande, Verdana, Microsoft YaHei"><SP=
AN style=3D"FONT-STYLE: normal"><SPAN style=3D"font-variant-ligat=
ures: normal"><SPAN style=3D"font-variant-caps: normal"><SPAN sty=
le=3D"FONT-WEIGHT: 400"><SPAN style=3D"LETTER-SPACING: normal"><S=
PAN style=3D"ORPHANS: 2"><SPAN style=3D"TEXT-TRANSFORM: none"><SP=
AN style=3D"WHITE-SPACE: normal"><SPAN style=3D"WIDOWS: 2"><SPAN =
style=3D"WORD-SPACING: 0px"><SPAN style=3D"text-decoration-style:=
 initial"><SPAN style=3D"text-decoration-color: initial"><SPAN st=
yle=3D"LINE-HEIGHT: 1.5"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN=
 style=3D"FONT-SIZE: small"><SPAN style=3D"LINE-HEIGHT: 1.5"><SPA=
N style=3D"BACKGROUND-COLOR: #ffffff">A:</SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN=
></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN> <SPAN s=
tyle=3D"FONT-SIZE: 14px"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN=
 style=3D"FONT-SIZE: small"><SPAN style=3D"COLOR: #003366"><SPAN =
style=3D"LINE-HEIGHT: 1.5">4th floor</SPAN></SPAN></SPAN></SPAN><=
/SPAN> <SPAN style=3D"FONT-SIZE: 14px"><SPAN style=3D"FONT-FAMILY=
: 'lucida Grande', Verdana, 'Microsoft YaHei'"><SPAN style=3D"COL=
OR: #003366"><SPAN style=3D"FONT-FAMILY: Arial"><SPAN style=3D"FO=
NT-SIZE: small"><SPAN style=3D"LINE-HEIGHT: 1.5">, Longyuntong Bu=
ilding, No. 164-5 Pengda Road,&nbsp;</SPAN></SPAN></SPAN></SPAN><=
/SPAN></SPAN></SPAN></SPAN> =0D=0A<DIV style=3D"TEXT-INDENT: 0px;=
 -webkit-text-stroke-width: 0px"><SPAN style=3D"WHITE-SPACE: norm=
al"><SPAN style=3D"WHITE-SPACE: normal"><SPAN style=3D"WHITE-SPAC=
E: normal"><SPAN style=3D"FONT-SIZE: 14px"><SPAN style=3D"LINE-HE=
IGHT: 1.5"><SPAN style=3D"COLOR: #000000"><SPAN style=3D"FONT-FAM=
ILY: 'lucida Grande', Verdana, 'Microsoft YaHei'"><SPAN style=3D"=
FONT-STYLE: normal"><SPAN style=3D"font-variant-ligatures: normal=
"><SPAN style=3D"font-variant-caps: normal"><SPAN style=3D"FONT-W=
EIGHT: 400"><SPAN style=3D"LETTER-SPACING: normal"><SPAN style=3D=
"ORPHANS: 2"><SPAN style=3D"TEXT-TRANSFORM: none"><SPAN style=3D"=
WHITE-SPACE: normal"><SPAN style=3D"WIDOWS: 2"><SPAN style=3D"WOR=
D-SPACING: 0px"><SPAN style=3D"BACKGROUND-COLOR: #ffffff"><SPAN s=
tyle=3D"text-decoration-thickness: initial"><SPAN style=3D"text-d=
ecoration-style: initial"><SPAN style=3D"text-decoration-color: i=
nitial"><SPAN style=3D"COLOR: #003366"><SPAN style=3D"FONT-FAMILY=
: Arial"><SPAN style=3D"FONT-SIZE: small"><SPAN style=3D"LINE-HEI=
GHT: 1.5">Longgang District, Shenzhen,China.</SPAN></SPAN></SPAN>=
</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></=
SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SP=
AN></SPAN></SPAN></SPAN></DIV></DIV></DIV></DIV></DIV></body></ht=
ml>
----boundary_2038_e2dfd44f-e10a-44db-802a-43f9f735f915--


