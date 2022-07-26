Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0858090C
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 03:36:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LsKJ52QS7z3byr
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 11:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=fu1bhZat;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=fu1bhZat;
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LsKHx0DfJz3bYS
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Jul 2022 11:36:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1658799358;
	bh=yxJImkNFC3yY4rbUn5Wc51ssWB9ydGySkwQIqMiTuuA=;
	h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
	b=fu1bhZatFGnIMmwOjDTbtjGcCmQGcMqcmwrpZPHCjJT0Ss3loVEXPt6MKVl09OmsK
	 9iTXG0szaXemNlsvcT3m+b5KS1Xx/5PH+60p+8YuSQKOs0Ipv81LZUYoMVmpyR1W91
	 Lei2CPQ9IcTtMLjZpXO4pbt9UsYu5OK+p0y0le9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1nrdW02A9J-00OUPe; Tue, 26
 Jul 2022 03:35:58 +0200
Message-ID: <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
Date: Tue, 26 Jul 2022 09:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
 <20220725222850.GA3420905@bill-the-cat>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
In-Reply-To: <20220725222850.GA3420905@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wH7FgsuLP+zatFMlHw0RaVgx39pJ0K6uTTnXvRelUGG3vOCo39J
 sJ6cbsMz847SEFasSI46hig9kugBIFJ7iDAL1QPYd/2QTexV+wSzgELRUtW8a3U3Zd1TsuO
 U1EbFmqgb/xeIdQtLCgT5xYaDaWIIXIJ/dBLK/6yI4VSNlR0ASis0Y4w85s+OCDRqHtSZBI
 8GiOEpeAmio7QFUD/OXMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jSmGu9NDuEo=:HJLgf8uEkvgge2LHSCn0T7
 SB8O7h4bRm38/gg2Se5pxiGDW6BE+uDFvsvx1A7nDZzzPAk/aQT/vcYpjq6OtHYMDocCniIO5
 iFzpWz5H4MXo36tOqcQVuIQ2LYWbMCQRFyWR8hhaFlIYkQMx5D99PdphAOf7lBN0i1Y3i/pJF
 2SRPP3ul1WMVinJlRjLNdLUhuCc+rtrTuRkRrOapbBoYqHRYuAPgsl4PkTBLnD66y4MIQ2z2U
 H6f34QMab6q1w/XBwqm9Z3dAVytYKHNlM+a5gzGbmW3pk21IdduWNzJwAfjS3hBunsY2xIeOu
 iyDuOYaOf01Ar6oRPc3sDQAG95x4P3z64S4snn2BDGjQRucvhiCqDoX2yDCOyxb9uiPhoxL7u
 cQgsaKxxbVDJ+1xTSnnZLoq4aKkiRx9ZY9/uVNwcVE0dRipUXMc6bYwdsonzG3bmNyjO5mgS5
 fK6mnnxmFjqytP4MXNbGL7k+Fxz1AxYUDWXt7Z7GxoZ3D+FjgX+6KXwkHNPMHNv2JcKhSFPud
 PQRSlFf8J8fJ13IufkGGsTkuUguq5ujLeS5USTcKCFHFt7zdkwIoig3CLmGj5Eau1QQYCwZCy
 JkGOTn//J4wNri770rsLyD8pAPir+ZNzMChkrM7IqZwJO9b1OJmeJcJjqG3qUnikb5ZM8Pndd
 We32z/O0GTR6SWiefDXRWVFBC1d+1LcMgyBVy+3yZR/Prv/LY+o5QER6SN2x1rPleXftgxNyg
 QbbF9krbQSgu6Ff9bBcm1eJSArpjGtNnDao+YblnTB0Wb5ao1SBnwail6ZY9FzsBsnimeIo11
 GttSGXTamfEZPzBBmRnVCGez1EmA5FOOpTPeTeQbHp/HFKe5/XRp2+xWUVGnCK3WyKAJThv5x
 KeplemRhcMFgduWFCVTUZGc1/avgA/8ZVVpDk2DNjBzjVnZhEA7KR5a6/03562L6G15vYGjkz
 uNgHXDURGLyz7miuGA/OiGbWcwSRk6q7Au8JxQK16FvU0UMwiJRQXyqwH/q4Qf9e2Stl6bdkg
 7jXiJk/V9Y4/bKqJPqDYXo0f0wOZ9EK/RqlEgMuSRH+od772OYbpRm+JA6hBUbt01pno2zePj
 6C5M0bgUhrqSW39ihMK9VvCvgiXUk0GuSS7zrm9uygRZoLlRf2/7biUhg==
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2022/7/26 06:28, Tom Rini wrote:
> On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:
>
>> That function is only utilized inside fat driver, unexport it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> The series has a fails to build on nokia_rx51:
> https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
> which to me says doing 64bit division (likely related to block size,
> etc) without using the appropriate helper macros to turn them in to bit
> shifts instead.
>
Should I update and resend the series or just send the incremental
update to fix the U64/U32 division?

Thanks,
Qu
