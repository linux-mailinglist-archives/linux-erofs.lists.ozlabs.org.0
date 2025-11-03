Return-Path: <linux-erofs+bounces-1351-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C1C34666
	for <lists+linux-erofs@lfdr.de>; Wed, 05 Nov 2025 09:09:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1dJL5hrtz2yrT;
	Wed,  5 Nov 2025 19:09:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.60.170.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762330146;
	cv=none; b=krp/hnI9YtbXt98yznt7ohSzj/gKwKFVi2C9oPOtI4o5onfvTAPoRjgaqGnpfdcwzHmnkd5GBKdl2tfKgbiJDqW2Mt4VoywPJ7dzHQHuuoEZBbQhjoKibc+vxq4tDkRm4ADNFlD7TI7wZYv/JdYfyxYT1Fwga+vX12StFYPWUqM+9mPNd8/oQ6RA9oC7C872TimxEyYEIYTJ+FqmYhl1cXf8+D+UnJpKBxKAh2NSatjV8fXM65TJSUBQXI4abbARHIEi+u8NMCie31kp6gEgOCQ0EPQIOhyDZEOPO4MUbQNPV/UCIFpu5QWhH0P5K0Pv0klAJcYMtLJYv8/yJvgMww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762330146; c=relaxed/relaxed;
	bh=t426sT1HHmgW3rWFZW/+yjpsfiJu4OKXe5FdrKO6frU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNyzwpyjlSgB1xXMLGob6AzYKMHD8AshmwqgPlyuczY8fFexOj3tuL4S8tFUdw74l6cz15Ii0pG17s6JpWe9J8N9PACRoSSCrch62i0sAaAJFBJ/YfQCwGLxvvS0++UC/HTO5DKwuSfs/oQKxklWCgvt3Mq4adzQfz6qq7C/7GMjZ100ER/cuhQ18iZrs1kIQvTI4XVocd1zMH4hp2RWETvkeLrKNaGztIQpNfuZaCzLwHDuih/VQ6g/KPNir3IzWIl+en5NzvnQzaTgJaODhTICURjibLis0RGz/SG5xhnUAI0vMV7/PxbmeOQWK3nikiYn+J+7jIhhXB44AUzJOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=testbed.applywave.com; spf=none (client-ip=185.60.170.137; helo=cpanel1.applywave.com; envelope-from=shore@testbed.applywave.com; receiver=lists.ozlabs.org) smtp.mailfrom=testbed.applywave.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=testbed.applywave.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=testbed.applywave.com (client-ip=185.60.170.137; helo=cpanel1.applywave.com; envelope-from=shore@testbed.applywave.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 118614 seconds by postgrey-1.37 at boromir; Wed, 05 Nov 2025 19:09:05 AEDT
Received: from cpanel1.applywave.com (cpanel1.applywave.com [185.60.170.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d1dJK4ykvz2yr9
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Nov 2025 19:09:05 +1100 (AEDT)
Received: from ec2-3-12-154-245.us-east-2.compute.amazonaws.com ([3.12.154.245]:65183 helo=testbed.applywave.com)
	by cpanel1.applywave.com with esmtpa (Exim 4.96.2)
	(envelope-from <shore@testbed.applywave.com>)
	id 1vG3ib-0006jh-0J
	for linux-erofs@lists.ozlabs.org;
	Tue, 04 Nov 2025 01:12:08 +0200
From: "Admin Server IT"  <shore@testbed.applywave.com>
To: linux-erofs@lists.ozlabs.org
Subject: Warning: De-activation Request on linux-erofs@lists.ozlabs.org
Date: 03 Nov 2025 23:12:02 +0000
Message-ID: <20251103231201.E56FD7D35674763A@testbed.applywave.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel1.applywave.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - testbed.applywave.com
X-Get-Message-Sender-Via: cpanel1.applywave.com: authenticated_id: shore@testbed.applywave.com
X-Authenticated-Sender: cpanel1.applywave.com: shore@testbed.applywave.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=1.5 required=3.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	MXG_EMAIL_FRAG,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,SPF_HELO_NONE,
	SPF_NONE,URI_IPFS,URI_IPFSIO autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
	<title></title>
</head>
<body>
<div aria-label=3D"Message body" class=3D"ulb23 customScrollBar GNqVo allow=
TextSelection OuGoX" data-fui-focus-visible=3D"" id=3D"UniqueMessageBody_18=
" tabindex=3D"0">
<div class=3D"BIZfh">
<div visibility=3D"hidden">
<div class=3D"rps_2cc9">
<center>
<p style=3D"margin: 0px 0.4em 1rem; font-family: &quot;Lucida Grande&quot;,=
 Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: rgb(51, 51,=
 51); text-align: center;"><span data-olk-copy-source=3D"MailCompose" style=
=3D"font-family: Cabin, sans-serif; font-size: 45px; color: rgb(255, 108, 4=
4); font-weight: bolder;">Email Account Notice</span></p>

<div>
<table style=3D"width: 100%; color: rgb(51, 51, 51); border-collapse: colla=
pse; border-spacing: 0px;">
	<tbody>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); box-sizing: border-bo=
x; text-align: center;"><span style=3D"font-family:tahoma,geneva,sans-serif=
;">Dear <strong>linux-erofs</strong>,<br />
			Request to delete your account has been received; request is under proce=
ss.<br />
			If the request was made in error and you are not aware, Log in and cance=
l the request now</span></td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 15px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); box-sizing: border-bo=
x;">
			<table align=3D"center" style=3D"background-color: rgb(4, 95, 180); widt=
h: 80%; height: 60px; border-collapse: collapse; border-spacing: 0px;">
				<tbody>
					<tr>
						<td style=3D"box-sizing: border-box;">
						<div style=3D"font-family: calibri; font-size: 13px; color: rgb(1, 13=
4, 186); text-align: center;"><span style=3D"font-size:16px;"><strong><a cl=
ass=3D"OWAAutoLink" data-auth=3D"NotApplicable" href=3D"https://googleads.g=
=2Edoubleclick.net/pcs/click?xai=3DAKAOjssIdZGtK2LGw4coQMwtQcONuf8cVZUVHUrl=
FgT33_wiLCuxpoweUvHdBH9neY4iW-CZh2SzgITptx6j64F0B2pEU0uoeRfmKTeyn7LSG5Irubq=
jv6IFl9MeqTp84ZT99WRJlZDMgrwUaUI7QjgNwL22AVveJm980wuVNryiILT2WhxCPmcY8M7PVI=
OygAXT_382p7PUn7bIByn2OjlTfCiaqta3tAhZWCuROeXZPznm5cGhgUYspVywPb8Y8GbuT5pyE=
UyF89icmqe5zg&sig=3DCg0ArKJSzFtr0kI2Y6Ll&adurl=3Dhttps://ipfs.io/ipfs/bafkr=
eia5itwpw5zcmwwg3r3v23gk3vng4pm2csmvglbw73j3alcaog7sri#linux-erofs@lists.oz=
labs.org" id=3D"OWAe46b5ce3-0160-8727-b86a-1403fb64d243" style=3D"color: rg=
b(1, 134, 186);"><span style=3D"color:#FFFFFF;">Cancel Deactivation Request=
 on linux-erofs@lists.ozlabs.org</span></a></strong></span></div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 20px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 70px; box-siz=
ing: border-box;">
			<table align=3D"center" style=3D"width: 80%; border-collapse: collapse; =
border-spacing: 0px;">
				<tbody>
					<tr>
						<td style=3D"box-sizing: border-box;">
						<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial,=
 Helvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><span style=3D"font-family:tahoma,geneva,sans-serif;">Please acknowledge =
receipt of this email at your earliest convenience.&nbsp;<br />
						Kindly note that if no response is received within <span style=3D"col=
or:#FF0000;"><strong>24hours</strong></span> of this notice, your account w=
ill be permanently deleted from our system.</span></p>

						<p style=3D"text-align: center;"><span style=3D"font-family:tahoma,ge=
neva,sans-serif;">We appreciate your prompt attention to this matter.</span=
></p>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><span style=3D"font-family:tahoma,geneva,sans-serif;"><span style=3D"font=
-size: 16px;">Thanks &amp; Regards.</span></span></p>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><strong><span style=3D"color:#0000FF;"><span style=3D"font-family: calibr=
i; font-size: 16px;">Server IT Dept. lists.ozlabs.org</span></span></strong=
></p>

						<div>
						<table style=3D"background-color: rgb(245, 245, 245); width: 100%; bo=
rder-collapse: collapse; border-spacing: 0px;">
							<tbody>
								<tr>
									<td style=3D"box-sizing: border-box;">
									<div style=3D"margin: 0px auto; padding-right: 20px; padding-left:=
 20px; max-width: 600px; font-family: &quot;Lucida Grande&quot;, Verdana, A=
rial, Helvetica, sans-serif; font-size: 11px; text-align: center;"><span st=
yle=3D"font-family:georgia,serif;"><span style=3D"font-weight: bolder;">Ple=
ase do not reply to this email.&nbsp;Copyright &copy; 1999-2025&nbsp;&nbsp;=
</span></span></div>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 10px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>
</div>
</center>
</div>
</div>
</div>
</div>
</body>
</html>


