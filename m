Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BC4E3B06
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 09:45:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KN4nQ0psZz2yPj
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 19:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=d7kMv8uN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=foxmail.com (client-ip=162.62.57.87;
 helo=out162-62-57-87.mail.qq.com; envelope-from=xkernel.wang@foxmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=d7kMv8uN; dkim-atps=neutral
X-Greylist: delayed 1732 seconds by postgrey-1.36 at boromir;
 Tue, 22 Mar 2022 19:45:24 AEDT
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KN4nJ51gfz2xXV
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 19:45:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1647938713;
 bh=ZhwrLpVxeb9axPGjqfL98j6rEPtndBto6xt6FHoWVFQ=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=d7kMv8uNhBtf6ZgUQcU8QQouwGb/e6iZJrekgUCcNrNaGrdGrsql1dxeCiobNNyv2
 OTo6jUpzVhRihwhXc/5AQvSoq20OnN7DvugfSf80YeYN31FAZIVh56kVNF39Me5mu8
 MS1/pV8ZdQbTPYGmOcmcEFAwLwINv4ad2Szrg6/I=
X-QQ-FEAT: oHWrrGTW1dA7H/rBCZjy5XfNuaD0tECu
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: OG3fjXpkFjhKoqZJ8p9LShZ0qRbZgWnC4h8mcUwCvFzrNZiMSE+n1Ho72vSgu/
 yFHdBzlz2y3pTtUhmmQe6DiwarocpDiM4FeByYS8glxyv2jUFrwwX+o+4tKk4KiMP/WW/t1boRg9V
 OfkxDG3rG+CyL3f3LtSy0+HEscqwPMiY+4PCNtg1OmSaqewDKP0MDHZ27uIcsfwSPVMY8MafKjkHU
 hLhOd/h9m4RHcEjHeQ4unrTPVSUZz+EydFuACugptDljljG/IogLRYTfnOkqFxEWAE5ht2MJV+pev
 AH3/okz6pKSpkuy+nhM/pgmJMEr/7QEJEnzqH1IUNHSr2iZwAp1UgVgWy3OJWvQuFh6TwuLerOTfa
 7JjBygQgtC67/84JjKr46eJVJoO17BaNdJaUY7k3KD/8LGSuA8ThUPSk+Nb4bnK5w63nNxd8gcqHc
 zKY8kW50tBJNWgp6orrfxUgFY4P/Km+Tit5AnNEBw6fYzro05R4IjcrIQvZ1LRO/LyVAxy4hKUqxN
 blwZR0jGBLSWIgI/4frZ1wHfD5SLBO5n/JcKvnlJ86vN/fNPu1CnNj/baqLEQonzQrGnMRSN35JW+
 QIBNXWEkpBJE4ZNu+NLGIuWB3poqmxliLQMlUCrrO1lc6O36LKqdLILuIp4vxXCV19yp3A98RBmTi
 tLy8DtVj7N4Yb7PMNNoaQ1RxyYzrGp6EnZb/tnjusGLnNxZkSjlDmo/SaZfKtZP08DTUmrkGGBg99
 QitjclRRR0TVxXPjqmmjFcS8JMZdgW+VT9M7tU7PMFZ+lM1GDy2yn3yTVe3kAzubhUOIK3N+UYeA1
 ozwu3s10alC3TjgmCSrcPvO9TZ/xisl9Rr8hJ9YETenmY4chstLJRMKCmgmjakTjNaiIqgEA4katV
 D8JEv8NTBobW5Ec1e1Kdw+lhb9buoInIMvXIvU6bh8=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
References: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
 <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1647938642t1340443
From: "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To: "=?ISO-8859-1?B?aHNpYW5na2Fv?=" <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 22 Mar 2022 16:44:02 +0800
X-Priority: 3
Message-ID: <tencent_A9204DCC4AB98B1CA0144FE1794AD8FFD708@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
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
Cc: =?ISO-8859-1?B?bGludXgtZXJvZnM=?= <linux-erofs@lists.ozlabs.org>,
 =?ISO-8859-1?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

T24gVHVlLCAyMiBNYXIgMjAyMiAxNjoyODowOSArMDgwMCwgaHNpYW5na2FvQGxpbnV4LmFs
aWJhYmEuY29tIHdyb3RlOgoKJmd0OyBJdCdzIHJlYWxseSBhIG5vZmFpbCBhbGxvY2F0aW9u
LCBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKU29ycnksIEkgZGlkIG5vdCBjYXJlZnVsbHkg
bm90aWNlIHRoZSBmbGFnIGBfX0dGUF9OT0ZBSUxgLgpQbGVhc2UgaWdub3JlIHRoaXMgcGF0
Y2ggaWYgdGhpcyBkb2VzIG5vdCBuZWVkIHRvIGRlYWwgd2l0aCBmYWlsdXJlLgoKUmVnYXJk
cywKWGlhb2tlIFdhbmc=

