Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 714508584C
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 04:50:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463tCv03sGzDqW7
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 12:50:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=126.com
 (client-ip=220.181.15.48; helo=m15-48.126.com;
 envelope-from=shenmeng999@126.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=126.com header.i=@126.com header.b="bvAK2cSB"; 
 dkim-atps=neutral
Received: from m15-48.126.com (m15-48.126.com [220.181.15.48])
 by lists.ozlabs.org (Postfix) with ESMTP id 463tCg5T5DzDqSH
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 12:50:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=MS8Cw
 Q3eDWGrGEwLiUipgV1UBEGGbZEjToeaG/fbp18=; b=bvAK2cSBRemwO7YPKmdnv
 0Kn82WRpj9P47803kZByojafFwOWBnlqtw7wBXWcyRR/twesYvqAkFFj6+uGuArp
 aFbInd0sk/RN7CyvuEGGAEMjjRQ8mo137yBXGrHvnFT8uOiTOZ3Ecns8SEu7d68f
 0X24l+3jEkbC67rb2Ylj2M=
Received: from shenmeng999$126.com ( [121.12.147.247] ) by
 ajax-webmail-wmsvr48 (Coremail) ; Thu, 8 Aug 2019 10:50:24 +0800 (CST)
X-Originating-IP: [121.12.147.247]
Date: Thu, 8 Aug 2019 10:50:24 +0800 (CST)
From: shenmeng999 <shenmeng999@126.com>
To: "Gao Xiang" <hsiangkao@aol.com>
Subject: Re:Re: [PATCH v2] erofs-utils: get block device size correctly
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <20190807182644.GA13848@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1565188615-19591-1-git-send-email-shenmeng999@126.com>
 <20190807182644.GA13848@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=gbk
MIME-Version: 1.0
Message-ID: <e551209.248f.16c6f227220.Coremail.shenmeng999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MMqowAAHH9fxjUtdQztDAA--.40522W
X-CM-SenderInfo: xvkh0z5hqjmmaz6rjloofrz/1tbiFhEL01pD+XUX9wAAsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

SGkgaHNpYW5na2FvOgogICAgSSBhZ3JlZSB3aXRoIHlvdXIgbW9kaWZpY2F0aW9uLkl0J3MgZ2V0
dGluZyBiZXR0ZXIuVGhhbmtzIQoKCkF0IDIwMTktMDgtMDggMDI6MjY6NTAsICJHYW8gWGlhbmci
IDxoc2lhbmdrYW9AYW9sLmNvbT4sIHNhaWQ6IAo+SGkgc2hlbm1lbmcsCj4KPk9uIFdlZCwgQXVn
IDA3LCAyMDE5IGF0IDEwOjM2OjU1UE0gKzA4MDAsIHNoZW5tZW5nOTk5QDEyNi5jb20gd3JvdGU6
Cj4+IEZyb206IHNoZW5tZW5nOTk2IDxzaGVubWVuZzk5OUAxMjYuY29tPgo+PiAKPj4gZnN0YXQg
cmV0dXJuIGJsb2NrIGRldmljZSdzIHNpemUgb2YgemVyby4KPj4gdXNlIGlvY3RsIHRvIGdldCBi
bG9jayBkZXZpY2UncyBzaXplLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogc2hlbm1lbmc5OTYgPHNo
ZW5tZW5nOTk5QDEyNi5jb20+Cj4KPgo+VGhhbmtzIGZvciB5b3VyIHBhdGNoIHYyIDopCj4KPkl0
IGxvb2tzIGdvb2QgdG8gbWUsIGFuZCBJIHVwZGF0ZSB0aGlzIHBhdGNoIHNvIHRoYXQKPmF1dG9j
b25mIGNhbiBjaGVjayB0aGVzZSBuZXcgaGVhZGVyIGZpbGVzLgo+aHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQveGlhbmcvZXJvZnMtdXRpbHMuZ2l0L2NvbW1p
dC8/aD1leHBlcmltZW50YWwmaWQ9MGYyMjU0NDk5NjJiNGE5NzE2OTg1ZTc1MzBhMzk1YTk1MDBk
MGRlNgo+RG8geW91IGFncmVlIHdpdGggdGhpcyBtb2RpZmljYXRpb24/IHBsZWFzZSBzaGFyZSB5
b3VyIHRob3VnaHQgYWJvdXQgdGhpcy4KPgo+VGhhbmtzLAo+R2FvIFhpYW5nCj4KPmRpZmYgLS1n
aXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPmluZGV4IDZmNGVhY2MuLmZjZGYzMGEg
MTAwNjQ0Cj4tLS0gYS9jb25maWd1cmUuYWMKPisrKyBiL2NvbmZpZ3VyZS5hYwo+QEAgLTczLDEy
ICs3MywxNCBAQCBBQ19DSEVDS19IRUFERVJTKG00X2ZsYXR0ZW4oWwo+IAlmY250bC5oCj4gCWlu
dHR5cGVzLmgKPiAJbGludXgvZmFsbG9jLmgKPisJbGludXgvZnMuaAo+IAlsaW51eC90eXBlcy5o
Cj4gCWxpbWl0cy5oCj4gCXN0ZGRlZi5oCj4gCXN0ZGludC5oCj4gCXN0ZGxpYi5oCj4gCXN0cmlu
Zy5oCj4rCXN5cy9pb2N0bC5oCj4gCXN5cy9zdGF0LmgKPiAJc3lzL3RpbWUuaAo+IAl1bmlzdGQu
aAo+ZGlmZiAtLWdpdCBhL2xpYi9pby5jIGIvbGliL2lvLmMKPmluZGV4IDkzMzI4ZDMuLjE1YzVh
MzUgMTAwNjQ0Cj4tLS0gYS9saWIvaW8uYwo+KysrIGIvbGliL2lvLmMKPkBAIC05LDcgKzksMTEg
QEAKPiAjZGVmaW5lIF9MQVJHRUZJTEU2NF9TT1VSQ0UKPiAjZGVmaW5lIF9HTlVfU09VUkNFCj4g
I2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4rI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgo+ICNpbmNsdWRl
ICJlcm9mcy9pby5oIgo+KyNpZmRlZiBIQVZFX0xJTlVYX0ZTX0gKPisjaW5jbHVkZSA8bGludXgv
ZnMuaD4KPisjZW5kaWYKPiAjaWZkZWYgSEFWRV9MSU5VWF9GQUxMT0NfSAo+ICNpbmNsdWRlIDxs
aW51eC9mYWxsb2MuaD4KPiAjZW5kaWYKPkBAIC0yMSw2ICsyNSwyNiBAQCBzdGF0aWMgY29uc3Qg
Y2hhciAqZXJvZnNfZGV2bmFtZTsKPiBzdGF0aWMgaW50IGVyb2ZzX2RldmZkID0gLTE7Cj4gc3Rh
dGljIHU2NCBlcm9mc19kZXZzejsKPiAKPitpbnQgZGV2X2dldF9ibGtkZXZfc2l6ZShpbnQgZmQs
IHU2NCAqYnl0ZXMpCj4rewo+KwllcnJubyA9IEVOT1RTVVA7Cj4rI2lmZGVmIEJMS0dFVFNJWkU2
NAo+KwlpZiAoaW9jdGwoZmQsIEJMS0dFVFNJWkU2NCwgYnl0ZXMpID49IDApCj4rCQlyZXR1cm4g
MDsKPisjZW5kaWYKPisKPisjaWZkZWYgQkxLR0VUU0laRQo+Kwl7Cj4rCQl1bnNpZ25lZCBsb25n
IHNpemU7Cj4rCQlpZiAoaW9jdGwoZmQsIEJMS0dFVFNJWkUsICZzaXplKSA+PSAwKSB7Cj4rCQkJ
KmJ5dGVzID0gKCh1NjQpc2l6ZSA8PCA5KTsKPisJCQlyZXR1cm4gMDsKPisJCX0KPisJfQo+KyNl
bmRpZgo+KwlyZXR1cm4gLWVycm5vOwo+K30KPisKPiB2b2lkIGRldl9jbG9zZSh2b2lkKQo+IHsK
PiAJY2xvc2UoZXJvZnNfZGV2ZmQpOwo+QEAgLTQ5LDcgKzczLDEyIEBAIGludCBkZXZfb3Blbihj
b25zdCBjaGFyICpkZXYpCj4gCj4gCXN3aXRjaCAoc3Quc3RfbW9kZSAmIFNfSUZNVCkgewo+IAlj
YXNlIFNfSUZCTEs6Cj4tCQllcm9mc19kZXZzeiA9IHN0LnN0X3NpemU7Cj4rCQlyZXQgPSBkZXZf
Z2V0X2Jsa2Rldl9zaXplKGZkLCAmZXJvZnNfZGV2c3opOwo+KwkJaWYgKHJldCkgewo+KwkJCWVy
b2ZzX2VycigiZmFpbGVkIHRvIGdldCBibG9jayBkZXZpY2Ugc2l6ZSglcykuIiwgZGV2KTsKPisJ
CQljbG9zZShmZCk7Cj4rCQkJcmV0dXJuIHJldDsKPisJCX0KPiAJCWJyZWFrOwo+IAljYXNlIFNf
SUZSRUc6Cj4gCQlyZXQgPSBmdHJ1bmNhdGUoZmQsIDApOwo+LS0gCj4yLjE3LjEK
