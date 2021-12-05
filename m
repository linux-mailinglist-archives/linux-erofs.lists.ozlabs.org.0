Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC69468C66
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Dec 2021 18:23:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J6YLt4vC4z2xtF
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 04:23:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=ofetyu.cn header.i=admin@ofetyu.cn header.a=rsa-sha1 header.s=key1 header.b=Y47C+KTv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ofetyu.cn (client-ip=113.31.116.20; helo=ofetyu.cn;
 envelope-from=admin@ofetyu.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=temperror header.d=ofetyu.cn header.i=admin@ofetyu.cn header.a=rsa-sha1
 header.s=key1 header.b=Y47C+KTv; dkim-atps=neutral
X-Greylist: delayed 610 seconds by postgrey-1.36 at boromir;
 Mon, 06 Dec 2021 04:23:38 AEDT
Received: from ofetyu.cn (unknown [113.31.116.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4J6YLf5ZPCz2xWt
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Dec 2021 04:23:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=key1; d=ofetyu.cn;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; i=admin@ofetyu.cn;
 bh=e0zyzLAjXxAuk0X0D8216HJy9tU=;
 b=Y47C+KTvs9GU08WPOjvSECqk1djuqdno/1m1Hl0YN+8m+eezTWGQGP9TsjYYWi8iGQjbB9ajMm3H
 eqvlPje4i7zRCG9ijM9ZKN6P+9O6i2Woy3ISdLpZspdqCe6fqW3YJHKsD1j1aWPUGCfKLCp6jTFp
 f8edytpNCIpgS4Ex6uKfjhaB05N48mfJLB3EOcrU/n1zFv1Fy65ZCv4GCHqo3lUI0ZXR2eTTBhF4
 yhnASSGKET3jWpQpbULJhrRupwu5dqwgD+JI0cbLcJAQQ+N9ccvLnXggdmKoVlNGAOZWsDnbU0Tf
 PDmvJfNliTS3yVTIeNsO3kY5oaFwQM4NdpHbiw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=key1; d=ofetyu.cn;
 b=KwLNLIOJuNPL57JVdXr6uUdG2+/Q64KleaaXGdlCtec8Nx8pLlqJMJEGbkC9Fl5h4n7kTMD4Gu+m
 Onj79s6mm6gKH92SNmDOLprIzi6YraxknGfkmfJevvMbIvJ8kjtHQuSamT6A7XSDfmt4F15qepBg
 S47OB9ptgln0Wu6DLgmyM6W1gRbbJcYfyUjEY6/xD6Ff5HyO8NwXML2I4IyTMsQhw0M9slaVfots
 3tR1BsKMDG8MASXRFaCJN0aQUSg+NTlhZgzdO7fltqOwfEoSz12cjqqXFlAqh6x8QVAMMRjFNmeC
 ebLcIE3Wu/gsGbEv6alY+rYEHd52VPHXDNBOQw==;
Received: by mail.ofetyu.cn id hljqpm0e97ce for <linux-erofs@lists.ozlabs.org>;
 Mon, 6 Dec 2021 01:13:10 +0800 (envelope-from <admin@ofetyu.cn>)
Message-ID: <20211206011309703201@ofetyu.cn>
From: "etc-meisai" <admin@ofetyu.cn>
To: <linux-erofs@lists.ozlabs.org>
Subject: =?gb2312?B?RSBUIEOltalgpdOluaTOpKrWqqTppLs=?=
Date: Mon, 6 Dec 2021 01:13:01 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0541_01F2EC8A.169D9E40"
X-mailer: Tjrrwan 2
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0541_01F2EC8A.169D9E40
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZyCYlA0KRSBUIEOltalgpdOluaTypLTA+9PDpKSk
v6TApK2koqTqpKykyKSmpLSktqSkpN6kuQ0KRSBUIEOltalgpdOluaTPn2+Ev6TLpMqk6qTepLek
v6GjDQrS/aStvkGkraW1qWCl06W5pPKktMD708OkpKS/pMCkraS/pKSI9rrPpM+hos/C05ul6qXz
pa+k6KTq1JS8mqTypLS0X9VKpK+kwKS1pKShow0KaHR0cHM6Ly9tZWlkaWpkLmNuP2V0YyANCqS0
srux46TIpLTQxMXkpPKkqqSrpLGkt6TepLekxtVcpMvJ6qS31FWktKS2pKSk3qS7pPOkrKGiDQq6
zqTIpL6ktMDtveLZbqTqpL+kr6Sq7oqkpMnqpLekoqSypN6kuaGjDQqh9iDXotLiysLtlw0KqaWp
pamlqaWppamlqaUNCqH5pMqkqqGiMjSVculn0tTE2qTLpLS0X9VKpKykyqSkiPa6z6Gi1Vyky996
urakyqSspOmhoqWipaulpqXzpcik8qXtpcOlr6S1pLukxqSkpL+kwKSvpLOkyKTyvq+45qSkpL+k
t6TepLkgDQqh+bG+peGpYKXrpM+hotbY0qqkyqSq1qqk6aS7pMikt6TGpeGpYKXrpM7F5NDFpPLP
o837pLWk7KTGpKSkyqSkpKq/zaS1pN6ky6TipKrLzaTqpLWku6TGpKSkv6TApKSkxqSqpOqk3qS5
oaO6ztfkpLTBy7PQpK+kwKS1pKShow0Kofmks6TOpeGpYKXrpMvQxLWxpL+k6qTOpMqkpKSrpL+k
z6Giv9ak7MjrpOqk3qS5pKyjxaPUo8OlpqWnpdaltaWkpcik6KTqpKqGlqSkus+k76S7pK+kwKS1
pKShow0KqaWppamlqaWppamlqaUNCqH2sGvQ0NXfDQqppamlqaWppamlqaWppQ0Ko8Wj1KPDwPvT
w9XVu+GltalgpdOlucrChNW+1g==

------=_NextPart_000_0541_01F2EC8A.169D9E40
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTEuMDAuMTA1NzAuMTAwMSI+PC9IRUFEPg0KPEJPRFk+DQo8UD5saW51eC1l
cm9mc0BsaXN0cy5vemxhYnMub3JnIJiUPEJSPkUgVCBDpbWpYKXTpbmk8qS0wPvTw6SkpL+kwKSt
pKKk6qSspMikpqS0pLakpKTepLk8L1A+DQo8UD5FIFQgQ6W1qWCl06W5pM+fb4S/pMukyqTqpN6k
t6S/oaM8QlI+0v2krb5BpK2ltalgpdOluaTypLTA+9PDpKSkv6TApK2kv6SkiPa6z6TPoaLPwtOb
peql86WvpOik6tSUvJqk8qS0tF/VSqSvpMCktaSkoaM8L1A+PEEgDQpocmVmPSJodHRwczovL21l
aWRpamQuY24/ZXRjIj5odHRwczovL21laWRpamQuY24/ZXRjPC9BPiANCjxQPqS0srux46TIpLTQ
xMXkpPKkqqSrpLGkt6TepLekxtVcpMvJ6qS31FWktKS2pKSk3qS7pPOkrKGiPEJSPrrOpMikvqS0
wO294tlupOqkv6SvpKruiqSkyeqkt6SipLKk3qS5oaM8L1A+DQo8UD6h9iDXotLiysLtlzxCUj6p
pamlqaWppamlqaWppTxCUj6h+aTKpKqhojI0lXLpZ9LUxNqky6S0tF/VSqSspMqkpIj2us+hotVc
pMvferq2pMqkrKTpoaKloqWrpaal86XIpPKl7aXDpa+ktaS7pMakpKS/pMCkr6SzpMik8r6vuOak
pKS/pLek3qS5IA0KPEJSPqH5sb6l4algpeukz6Gi1tjSqqTKpKrWqqTppLukyKS3pMal4algpeuk
zsXk0MWk8s+jzfuktaTspMakpKTKpKSkqr/NpLWk3qTLpOKkqsvNpOqktaS7pMakpKS/pMCkpKTG
pKqk6qTepLmho7rO1+SktMHLs9Ckr6TApLWkpKGjPEJSPqH5pLOkzqXhqWCl66TL0MS1saS/pOqk
zqTKpKSkq6S/pM+hor/WpOzI66TqpN6kuaSso8Wj1KPDpaalp6XWpbWlpKXIpOik6qSqhpakpLrP
pO+ku6SvpMCktaSkoaM8QlI+qaWppamlqaWppamlqaU8QlI+ofawa9DQ1d88QlI+qaWppamlqaWp
pamlqaU8QlI+o8Wj1KPDwPvTw9XVu+GltalgpdOlucrChNW+1jwvUD48L0JPRFk+PC9IVE1MPg0K

------=_NextPart_000_0541_01F2EC8A.169D9E40--

