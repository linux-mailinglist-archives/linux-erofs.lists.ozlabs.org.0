Return-Path: <linux-erofs+bounces-49-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE15A5CF33
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Mar 2025 20:22:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZC3Ym0T6Qz2xmk;
	Wed, 12 Mar 2025 06:22:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=157.7.215.29
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741720955;
	cv=none; b=LMR+eBS639euBxnycmlE4osKabsXVhKw2KodVqtAn+DR3PaM/Zt9BwdLp/Q6W84F3HjlV3OCgZFP0Z1s+owMSSzj13TkXbNYwxnHqb1Ai9D3T5xH3ACpIMgKEP9F55j4ybvrdpBmee6XCFsr1ybCcm+4mgpZhnc3v0N49xtvZ9o5HCnDhKRpJO6gIVKaKVDoQnebe7oGOHwhN+Qigz9M45mZva+OGw5OmVnNp76ANBBpJjuxnRqDFO92vPrg+8wvGWQdTPA2+jeF6gonOzS/4X2/NctZ1Okfp3/NS86uAbP9fWSkhWdRnbSb37roXMbWkqEiDv5ss88P9W4VAEWucw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741720955; c=relaxed/relaxed;
	bh=gwsN8s5W8qekM6yCAABUh/m+A/+HB6yWOgcuCh9FGMw=;
	h=Date:From:To:Subject:MIME-Version:Message-ID:Content-Type; b=hMXq0l0nghiny6TGWp2pwLOql7qiRQhTMSWgQwUrB6JojggBwO/p+fDXZdLRtSkiirEMDbskzFPDG5rnDjDIjEeU5Ef0IXvg3VBtW7HWXFr9G6H+xYkVWLnXU4L5Ucu4sfNr6xFZsNfrFUKnKNkaBy8EQ4kX00gTapGXs9f1CYaXCIhZmDFstxxQTIgYoeYzWL+mmtJTwo8wOp2s3cZBX2ykhlzuhogbWzLJsC5kFYqqMyaGEVsNEAKBh9EVzVSVg8XF9wAgtKstFGnY4Q1FrvSZUE/RkgBvwWfDDH78NJKsbqE9qUTtWFmdt1pUME4Z+WF9z3EuxtAEJtcfA9yICw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=515173.com; dkim=pass (2048-bit key; unprotected) header.d=515173.com header.i=@515173.com header.a=rsa-sha256 header.s=mail header.b=KT0j4jh3; dkim-atps=neutral; spf=pass (client-ip=157.7.215.29; helo=515173.com; envelope-from=service_1@515173.com; receiver=lists.ozlabs.org) smtp.mailfrom=515173.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=515173.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=515173.com header.i=@515173.com header.a=rsa-sha256 header.s=mail header.b=KT0j4jh3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=515173.com (client-ip=157.7.215.29; helo=515173.com; envelope-from=service_1@515173.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 332 seconds by postgrey-1.37 at boromir; Wed, 12 Mar 2025 06:22:33 AEDT
Received: from 515173.com (v157-7-215-29.1ww5.static.cnode.io [157.7.215.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZC3Yj6PXXz2xjK
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 06:22:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=515173.com; s=mail;
	t=1741720615; bh=vtLIvompuq9Kaj+01zDVlyVgfwrsdMnYMc9dlMcp/LA=;
	h=Date:From:To:Subject:From;
	b=KT0j4jh3XHCa1F8yaF5JNcVULQeB+moOwZeuFESyyrvk3T1PfHFk2Xz7W6DUSmKwK
	 NL08uIJnd7MWF4U488VXR+VmpmLCK+TMYT75B9NvIPQYj+JCLvG1dpnW9+7jXCT4lm
	 5AXTXDzjKATQcJl+UHHi6OGGZKwBWiBu++0LcyOKv1qcRMFVray5C4KTfYqst4LM/3
	 TTlsakiawuwBtOBODr37iG2Qew5BbjiCDbRMj8ypumh6wWWtHqhXVnp89Ij914NWkn
	 0ixf3tiJMQLrvQj2GggP59TGm0vzO5sUYGWBJg2ePy7l29RAb/JQtsIyrpxRRmmrbx
	 0OvtUismGTkZg==
Received: from 515173.com (v157-7-89-244.29kw.static.cnode.io [157.7.89.244])
	by 515173.com (Postfix) with ESMTPSA id E1FED142218
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 04:16:55 +0900 (JST)
Date: Wed, 12 Mar 2025 04:16:41 +0900
From: "=?utf-8?B?5qW95aSp6Ki85Yi444GL44KJ44Gu44GK55+l44KJ44Gb?=" <service_1@515173.com>
To: "linux-erofs" <linux-erofs@lists.ozlabs.org>
Subject: =?utf-8?B?6YeN6KaB44Gq44GK55+l44KJ44Gb772cMjAyNeW5tDPmnIgxMuaXpeS7pemZjQ==?=
	=?utf-8?B?44Gu44Ot44Kw44Kk44Oz5pmC44Gr44CK44K144Kk44OI44GU5Yip55So44Gr44GC44Gf44Gj44Gm44Gu?=
	=?utf-8?B?44GU55WZ5oSP5LqL6aCF44CL44Gu56K66KqN44GM5b+F6KaB44Gn44GZ?=
X-Priority: 3 (Normal)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Message-ID: <1510214A.25866866@515173.com>
Content-Type: multipart/alternative;
	boundary="NetEase-FlashMail-001-82c5b451-4222-d579-227e-dbd1a6497ff7"
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.0
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

This is a multi-part message in MIME format.

--NetEase-FlashMail-001-82c5b451-4222-d579-227e-dbd1a6497ff7
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

6YeN6KaB44Gq44GK55+l44KJ44GbDQrjgYrlrqLmp5jlkITkvY0NCg0K5bmz57Sg44KI44KK5qW9
5aSp6Ki85Yi444KS44GU5Yip55So44GE44Gf44Gg44GN44CB6Kqg44Gr44GC44KK44GM44Go44GG
44GU44GW44GE44G+44GZ44CCDQoNCjIwMjXlubQy5pyIMjjml6XjgavmlLnlrprjgZXjgozjgZ/j
gIzmpb3lpKnjga7oqLzliLjlj5blvJXntITmrL7jgI3jgavkvLTjgYTjgIHjgqrjg7Pjg6njgqTj
g7PjgrXjg7zjg5PjgrnntITmrL7jgYzlpInmm7TjgZXjgozjgb7jgZnjgILjgZPjgozjgavjgojj
gorjgIEyMDI15bm0M+aciDEy5pel5Lul6ZmN44CB44Kq44Oz44Op44Kk44Oz44K144O844OT44K5
44Gr44Ot44Kw44Kk44Oz44GZ44KL6Zqb44Gr44CB44CK44K144Kk44OI44GU5Yip55So44Gr44GC
44Gf44Gj44Gm44Gu44GU55WZ5oSP5LqL6aCF44CL44Gu56K66KqN55S76Z2i44GM6KGo56S644GV
44KM44G+44GZ44CCDQoNCuOCteOCpOODiOOBruWIqeS+v+aAp+WQkeS4iuOChOOCteODvOODk+OC
ueaUueWWhOOBruOBn+OCgeOAgeOBiuaJi+aVsOOBp+OBmeOBjOOAgeS7peS4i+OBruODquODs+OC
r+OCiOOCiuOBlOeiuuiqjeODu+OBlOWbnuetlOOCkuOBiumhmOOBhOOBhOOBn+OBl+OBvuOBmeOA
gg0KDQrwn5GJIGh0dHBzXzovL3d3dy5yYWt1dGVuLXNlYy5jby4ganAvd2ViL2NvbXBhbnkvDQoN
CuKaoOOBlOazqOaEjw0K44CM5LuK44Gv5ZCM5oSP44GX44Gq44GE44CN44KS6YG45oqe44GV44KM
44Gf5aC05ZCI44CBM+aXpeW+jOOBq+WGjeW6pueiuuiqjeeUu+mdouOBjOihqOekuuOBleOCjOOB
vuOBmeOAgg0KDQrwn5OMIOmWoumAo+ODquODs+OCrw0K8J+TnOOAjOalveWkqeOBruiovOWIuOWP
luW8lee0hOasvuOAjeS4gOmDqOaUueWumuOBq+OBpOOBhOOBpg0K8J+TjOOAjOOCteOCpOODiOOB
lOWIqeeUqOOBq+OBguOBn+OBo+OBpuOBruOBlOeVmeaEj+S6i+mgheOAjQ0KDQrmnKzjg6Hjg7zj
g6vjga/pgIHkv6HlsILnlKjjgafjgZnjga7jgafjgIHnm7TmjqXjgZTov5Tkv6HjgYTjgZ/jgaDj
gZHjgb7jgZvjgpPjgIINCuOBlOS4jeaYjuOBqueCueOBjOOBlOOBluOBhOOBvuOBl+OBn+OCieOA
geS7peS4i+OBruODmuODvOOCuOOCiOOCiuOBiuWVj+OBhOWQiOOCj+OBm+OBj+OBoOOBleOBhOOA
gg0K8J+UjSDjgYrllY/jgYTlkIjjgo/jgZvkuIDopqcNCg0K5LuK5b6M44Go44KC5qW95aSp6Ki8
5Yi444KS44KI44KN44GX44GP44GK6aGY44GE44GE44Gf44GX44G+44GZ44CCDQoNCualveWkqeio
vOWIuOagquW8j+S8muekvg0KwqkgUmFrdXRlbiBTZWN1cml0aWVzLCBJbmMuDQo=

--NetEase-FlashMail-001-82c5b451-4222-d579-227e-dbd1a6497ff7
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MIGxhbmc9amE+PEhFQUQ+PFRJVExFPumHjeimgeOBquOBiuefpeOCieOBmzwv
VElUTEU+DQo8TUVUQSBjaGFyc2V0PVVURi04Pg0KPE1FVEEgbmFtZT12aWV3cG9ydCBjb250ZW50
PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MS4wIj4NCjxNRVRBIG5hbWU9R0VO
RVJBVE9SIGNvbnRlbnQ9Ik1TSFRNTCAxMS4wMC4xMDU3MC4xMDAxIj48bWV0YSBjb250ZW50PSJ0
ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiIGh0dHAtZXF1aXY9Q29udGVudC1UeXBlPg0KPC9oZWFk
Pg0KPEJPRFkgc3R5bGU9IkZPTlQtRkFNSUxZOiBBcmlhbCwgc2Fucy1zZXJpZjsgTElORS1IRUlH
SFQ6IDEuNiI+DQo8UCBkYXRhLXN0YXJ0PSI2NCIgZGF0YS1lbmQ9Ijc1Ij48U1RST05HIGRhdGEt
c3RhcnQ9IjY0IiANCmRhdGEtZW5kPSI3MyI+44GK5a6i5qeY5ZCE5L2NPC9TVFJPTkc+PC9QPg0K
PFAgZGF0YS1zdGFydD0iNzciIGRhdGEtZW5kPSIxMDkiPuW5s+e0oOOCiOOCiualveWkqeiovOWI
uOOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOAgeiqoOOBq+OBguOCiuOBjOOBqOOBhuOBlOOBluOB
hOOBvuOBmeOAgjwvUD4NCjxQIGRhdGEtc3RhcnQ9IjExMSIgDQpkYXRhLWVuZD0iMjM2Ij4yMDI1
5bm0MuaciDI45pel44Gr5pS55a6a44GV44KM44Gf44CM5qW95aSp44Gu6Ki85Yi45Y+W5byV57SE
5qy+44CN44Gr5Ly044GE44CB44Kq44Oz44Op44Kk44Oz44K144O844OT44K557SE5qy+44GM5aSJ
5pu044GV44KM44G+44GZ44CC44GT44KM44Gr44KI44KK44CBPFNUUk9ORyANCmRhdGEtc3RhcnQ9
IjE2NyIgDQpkYXRhLWVuZD0iMjI5Ij4yMDI15bm0M+aciDEy5pel5Lul6ZmN44CB44Kq44Oz44Op
44Kk44Oz44K144O844OT44K544Gr44Ot44Kw44Kk44Oz44GZ44KL6Zqb44Gr44CB44CK44K144Kk
44OI44GU5Yip55So44Gr44GC44Gf44Gj44Gm44Gu44GU55WZ5oSP5LqL6aCF44CL44Gu56K66KqN
55S76Z2i44GM6KGo56S6PC9TVFJPTkc+44GV44KM44G+44GZ44CCPC9QPg0KPFAgZGF0YS1zdGFy
dD0iMjM4IiANCmRhdGEtZW5kPSIyOTIiPuOCteOCpOODiOOBruWIqeS+v+aAp+WQkeS4iuOChOOC
teODvOODk+OCueaUueWWhOOBruOBn+OCgeOAgeOBiuaJi+aVsOOBp+OBmeOBjOOAgeS7peS4i+OB
ruODquODs+OCr+OCiOOCiuOBlOeiuuiqjeODu+OBlOWbnuetlOOCkuOBiumhmOOBhOOBhOOBn+OB
l+OBvuOBmeOAgjwvUD4NCjxQIGRhdGEtc3RhcnQ9IjI5NCIgZGF0YS1lbmQ9IjMzMiI+8J+RiSA8
QSANCmhyZWY9Imh0dHBzOi8vZmV2cGdzYnUudG9wL2pvaWZlIj48U1RST05HPmh0dHBzXzovL3d3
dy5yYWt1dGVuLXNlYy5jby4gDQpqcC93ZWIvY29tcGFueS88L1NUUk9ORz48L0E+PC9QPg0KPFAg
ZGF0YS1zdGFydD0iMzM0IiBkYXRhLWVuZD0iMzg4Ij48U1RST05HIGRhdGEtc3RhcnQ9IjMzNCIg
DQpkYXRhLWVuZD0iMzQyIj7imqDjgZTms6jmhI88L1NUUk9ORz48QlIgZGF0YS1zdGFydD0iMzQy
IiANCmRhdGEtZW5kPSIzNDUiPuOAjOS7iuOBr+WQjOaEj+OBl+OBquOBhOOAjeOCkumBuOaKnuOB
leOCjOOBn+WgtOWQiOOAgTxTVFJPTkcgZGF0YS1zdGFydD0iMzYzIiANCmRhdGEtZW5kPSIzODEi
PjPml6Xlvozjgavlho3luqbnorroqo3nlLvpnaLjgYzooajnpLo8L1NUUk9ORz7jgZXjgozjgb7j
gZnjgII8L1A+DQo8UCBkYXRhLXN0YXJ0PSIzOTAiIGRhdGEtZW5kPSI1NzgiPvCfk4wgPFNUUk9O
RyBkYXRhLXN0YXJ0PSIzOTMiIA0KZGF0YS1lbmQ9IjQwMiI+6Zai6YCj44Oq44Oz44KvPC9TVFJP
Tkc+PEJSIGRhdGEtc3RhcnQ9IjQwMiIgZGF0YS1lbmQ9IjQwNSI+PEEgDQpocmVmPSJodHRwczov
L3d3dy5yYWt1dGVuLXNlYy5jby5qcC93ZWIvaW5mby9pbmZvMjAyNDAyMDktMDEuaHRtbCIgcmVs
PW5vb3BlbmVyIA0KdGFyZ2V0PV9uZXcgZGF0YS1zdGFydD0iNDA1IiBkYXRhLWVuZD0iNDg5Ij7w
n5Oc44CM5qW95aSp44Gu6Ki85Yi45Y+W5byV57SE5qy+44CN5LiA6YOo5pS55a6a44Gr44Gk44GE
44GmPC9BPjxCUiANCmRhdGEtc3RhcnQ9IjQ4OSIgZGF0YS1lbmQ9IjQ5MiI+PEEgDQpocmVmPSJo
dHRwczovL3d3dy5yYWt1dGVuLXNlYy5jby5qcC93ZWIvaW5mby9pbmZvMjAxNjA0MjYtMDEuaHRt
bCIgcmVsPW5vb3BlbmVyIA0KdGFyZ2V0PV9uZXcgZGF0YS1zdGFydD0iNDkyIiBkYXRhLWVuZD0i
NTc2Ij7wn5OM44CM44K144Kk44OI44GU5Yip55So44Gr44GC44Gf44Gj44Gm44Gu44GU55WZ5oSP
5LqL6aCF44CNPC9BPjwvUD4NCjxQIGRhdGEtc3RhcnQ9IjU4MCIgZGF0YS1lbmQ9IjY5NyI+5pys
44Oh44O844Or44Gv6YCB5L+h5bCC55So44Gn44GZ44Gu44Gn44CB55u05o6l44GU6L+U5L+h44GE
44Gf44Gg44GR44G+44Gb44KT44CCPEJSIA0KZGF0YS1zdGFydD0iNjA3IiBkYXRhLWVuZD0iNjEw
Ij7jgZTkuI3mmI7jgarngrnjgYzjgZTjgZbjgYTjgb7jgZfjgZ/jgonjgIHku6XkuIvjga7jg5rj
g7zjgrjjgojjgorjgYrllY/jgYTlkIjjgo/jgZvjgY/jgaDjgZXjgYTjgII8QlIgDQpkYXRhLXN0
YXJ0PSI2NDMiIGRhdGEtZW5kPSI2NDYiPvCflI0gPFNUUk9ORyBkYXRhLXN0YXJ0PSI2NDkiIGRh
dGEtZW5kPSI2OTUiPjxBIA0KaHJlZj0iaHR0cHM6Ly9mYXEucmFrdXRlbi1zZWMuY28uanAvIiBy
ZWw9bm9vcGVuZXIgdGFyZ2V0PV9uZXcgZGF0YS1zdGFydD0iNjUxIiANCmRhdGEtZW5kPSI2OTMi
PuOBiuWVj+OBhOWQiOOCj+OBm+S4gOimpzwvQT48L1NUUk9ORz48L1A+DQo8UCBkYXRhLXN0YXJ0
PSI2OTkiIGRhdGEtZW5kPSI3MjMiPuS7iuW+jOOBqOOCgualveWkqeiovOWIuOOCkuOCiOOCjeOB
l+OBj+OBiumhmOOBhOOBhOOBn+OBl+OBvuOBmeOAgjwvUD4NCjxQIGRhdGEtc3RhcnQ9IjcyNSIg
ZGF0YS1lbmQ9Ijc2NiIgZGF0YS1pcy1sYXN0LW5vZGU9IiIgDQpkYXRhLWlzLW9ubHktbm9kZT0i
Ij48U1RST05HIGRhdGEtc3RhcnQ9IjcyNSIgDQpkYXRhLWVuZD0iNzM3Ij7mpb3lpKnoqLzliLjm
oKrlvI/kvJrnpL48L1NUUk9ORz48QlIgZGF0YS1zdGFydD0iNzM3IiBkYXRhLWVuZD0iNzQwIj7C
qSBSYWt1dGVuIA0KU2VjdXJpdGllcywgSW5jLjwvUD48L0JPRFk+PC9IVE1MPg0K

--NetEase-FlashMail-001-82c5b451-4222-d579-227e-dbd1a6497ff7--


