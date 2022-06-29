Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239DF55F2EF
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 03:46:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXkpR6ydHz3cDT
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 11:46:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=dJxpPLJ1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=dJxpPLJ1;
	dkim-atps=neutral
X-Greylist: delayed 312 seconds by postgrey-1.36 at boromir; Wed, 29 Jun 2022 11:46:32 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXkpJ4sP1z3bXG
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 11:46:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1656467189;
	bh=Mgh6GpcVYx/rYDWIwnSClfH6GngeEz8fNAlGj9uUiJc=;
	h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
	b=dJxpPLJ1pjymlx9gjmmCoJJ7zH3J2oCSM0AaSi3GOmllcTeqkweBXyjmof27GfBc+
	 fM9hSpTz1g8SZ5wBwijho3y7Dg5YnMJEXhxGcxVqc4bbT+eaWpz70aooaFYVrpKBjf
	 AczVQqs59Pcf2VHpHc4RALubYxoyikFZ4/p5e1pI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof9P-1nHKQ539B3-00p2Jq; Wed, 29
 Jun 2022 03:41:05 +0200
Message-ID: <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
Date: Wed, 29 Jun 2022 09:40:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
 <20220628141708.GJ1146598@bill-the-cat>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
In-Reply-To: <20220628141708.GJ1146598@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cebTUJIiPO7+NBMRZERKrkPZtn4e1sMamamdtPGgz7/PydPbOH
 yR2nsTNBPGmyNF5SXa9y5NqMlQe3jkUVDru2HRmT0vhEHXgNNdfYwyYwFmDFbavIu/Q5Hat
 PTg3TJ4QBESn6cP94Vq6rrCkYHq++o00bkiFKv8XTM3SpB9nIE9fsP18BrAEVGWGpG674ad
 rfleXQkNxMRr2MMYn/DVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WaYo+HCJiXc=:wXg9h3JFbakDnOSDmB5TGJ
 DRY0fHhLM/AL2Bdv9YXZNvBb2cJgMnZPxf9tQZAnOGB/h3/h0uOBotSAaXx2D4uY90khPEHmT
 viT2u5JGs+6a/jnhoOhGXs2a1l+jEuO1EeKZU/VcuRFdUAtYd6zhiMoc8n1tkqGtLiHNTyZSN
 054jwm2Y8LNTU6Jg49eVtTIk7fSV3Jz/w6/AbPN73cJOS15TWbrCV2I5Yot5Tc+GJ6CJrPX1N
 rsXIpZEHhDPDcVyURSvGINAiZnRdy3orJs6ggGdd83/9grsOPKXC/zRFoXi0bN/PWZhjo+q61
 T8+1LQzYoAcukoPJUY/xVsn298Z3C/Y3/qzqUbvBMFi72iSoogUkaElDh9j2eLoM7fnc0qPBi
 rkX5tvWeGXiRfsryXO0MteS3yesOw6F4Wo5zm/teG1sVzwj7n9SRFKwtBM3QzFtrFVePWmNC4
 Ne/dEVvgOPwXjOk/JeU2EC5BU36i62U461Z5vHlwiLJxTLlTmLczcfTnKhUKi3rk9Ap845ao9
 j9hqe8Lb5kE3oZ41IPAVU163+J6oF9LEcUstRJukoSWSD3CbVG1EawP9RYkGZOEa8IlB+zZYE
 otRVuLHHMTDGwfbUs/SpKkgxBjeOiohWU79DflrTlCZhI3JdnshxAUQ5QVpLKrq71gf1l0NNG
 T35PwW6JpDpxxJXxSKKV3zevuCou8Fr7bb3H13qYX1OivfnlKltdEXuJ8HranTdD4zDGtsWEc
 bH0iWlo3L8JFka+NzMyFpTTZei2kLZcQEHbuCpxoCoUqdtnITZ0ec8Hd5/fehhSKA9OLq2hXe
 ZR7C3mnbJUHjgNmQwbKOAOeC5q44vXJcwpTsoZyqsFPu7HExOmOO0Xe+vVZ41yh8k8e0dnWUa
 kE2UaEcJUSrQNoZsT+H82sx5/tnuzZZSLWAAqPJan2nmgryHaWPw3hzW4CtPd3DnaIgMQaVHI
 f6JoJh98vJxVTX2HnVMf0ISSZ4cZXjr3puwaK03YFjww+LqKrtGbmPdjbH1QfsLKHTXoPFHM3
 xnwFJwrPHmrfD0TAGZgx+LmUlxXSWi25jlAXkbROp1TvXMDRNpYvV0PzLV5L6DC0klW5Dc8V9
 RE0MTGJ7EtPtoaPf+CHOvMALGV/qvbx15TzhfxRaZBSYxSXGqmIEJ1l3Q==
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
Cc: jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2022/6/28 22:17, Tom Rini wrote:
> On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
>> just pass the request range to underlying fses.
>>
>> Under most case, this works fine, as U-boot only really needs to read
>> the whole file (aka, 0 for both offset and len, len will be later
>> determined using file size).
>>
>> But if some advanced user/script wants to extract kernel/initramfs from
>> combined image, we may need to do unaligned read in that case.
>>
>> [ADVANTAGE]
>> This patchset will handle unaligned read range in _fs_read():
>>
>> - Get blocksize of the underlying fs
>>
>> - Read the leading block contianing the unaligned range
>>    The full block will be stored in a local buffer, then only copy
>>    the bytes in the unaligned range into the destination buffer.
>>
>>    If the first block covers the whole range, we just call it aday.
>>
>> - Read the aligned range if there is any
>>
>> - Read the tailing block containing the unaligned range
>>    And copy the covered range into the destination.
>>
>> [DISADVANTAGE]
>> There are mainly two problems:
>>
>> - Extra memory allocation for every _fs_read() call
>>    For the leading and tailing block.
>>
>> - Extra path resolving
>>    All those supported fs will have to do extra path resolving up to 2
>>    times (one for the leading block, one for the tailing block).
>>    This may slow down the read.
>
> This conceptually seems like a good thing.  Can you please post some
> before/after times of reading large images from the supported
> filesystems?
>

One thing to mention is, this change doesn't really bother large file read=
.

As the patchset is splitting a large read into 3 parts:

1) Leading block
2) Aligned blocks, aka the main part of a large file
3) Tailing block

Most time should still be spent on part 2), not much different than the
old code. Part 1) and Part 3) are at most 2 blocks (aka, 2 * 4KiB for
most modern large enough fses).

So I doubt it would make any difference for large file read.


Furthermore, as pointed out by Huang Jianan, currently the patchset can
not handle read on soft link correctly, thus I'd update the series to do
the split into even less parts:

1) Leading block
    For the unaligned initial block

2) Aligned blocks until the end
    The tailing block should still starts at a block aligned position,
    thus most filesystems is already handling them correctly.
    (Just a min(end, blockend) is enough for most cases already).

Anyway, I'll try to craft some benchmarking for file reads using sandbox.
But please don't expect much (or any) difference in that case.

Thanks,
Qu
