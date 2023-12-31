Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B152B820995
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 03:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1703990758;
	bh=iyShud6ixGTGsi+8mJNqmZ+hFsJHCavb2SUbHPreU00=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IbY8wu5gJD97vEY+1UQnQ4rlX9z7YCUorzM1FwgK92CRrSc8epTKzOR2C/n/2NVr7
	 l+i2kcwDPthjfHFWj4jt/H4h9z4mTr7OU28vuJGcsimhbIA/BwG2kT5hHqk4wvNJWn
	 E9jlpkVZK4b+0LTPjlVysTvjFchvwkLTyGGUxyjJZ40PEuo4pnbXIB3vRjrgbp2kgy
	 tg4hBtBHg9bhFn7ZZ+8ur6nTH+LlaFPsWFgratwiZaoC/E6m0uGhipG0Bwj3ADuD2H
	 ktxPNx5AxFUEfwiS780rVhnr96irru4OSrawZmUZyk6Q9EC6VV4y3Jb2fXL7KR7noj
	 i+K8PMgkx0rhw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T2k5264xpz2ytN
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 13:45:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ciHl1mY9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 139764 seconds by postgrey-1.37 at boromir; Sun, 31 Dec 2023 13:45:52 AEDT
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T2k4w1LrYz2xcp
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Dec 2023 13:45:51 +1100 (AEDT)
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 8172203F; Sun, 31 Dec 2023 10:32:23 +0800
X-QQ-mid: xmsmtpt1703989943t611qma8z
Message-ID: <tencent_2F7B3A6ED02C496EFC965CE96EEDFECDB40A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69Y3XCpPld6XvBHv0DEOlzwgQbasw5H9sw/KRxE79V04YJPjICau
	 0khGOH6y0rPQC8PAAv9PLU53DGZAjSypnDwmSAH4IoK8BhHH4jlYzDo8oqQQ6s4h3gc9BdjdrPEu
	 hTy++H9Lu18YA9XUO316W4NenV/LiZK8eBrqf+trppOiO3Q7jIu6ZL52vm9oUHTDQm/cSjJo7z60
	 xUPj86X8JzQyNo5za5opCjfc0Jvi4uG3/fzcxCQHgIv07uSupg8akCwAKq6JG1gFGaqcI/nnh6pT
	 9BoSYLzhrkKGz8kPwlCL1ULbYIBfqnWH/eaMfQthua0euumPvwZoaUM2H4ZRXkeTGQJ1+nIohvsO
	 yk6UWgHHaKli6vQL+DlPcL+apXpR0tBeMnL2R4SKkQBvjSF03m3XdklL0pX2kJpEbAFNB0cAzoKC
	 nRpqlVd/6SkxfhwzKFtNYnCxEJaouUXAQhPpZEUGA3k//fvHnCL82axVfS/HRpBByYvRTgaCAbZZ
	 cA9JXShPiZ5btS2h4SgFXSZi5sOE10YH/2Ug170Mt+U9MujVWc3qMRXyF8GoZkh1yQ2xp3kYnQ+O
	 WZ0lfp3W9BNUwOX7wA3HXwU19+iOBQ2ZCWjXjQgWt5iF8XLMheszUjkOIZTWkokxU5QLTlROq85q
	 MLDKy354VBpm5zB8J1g6YGTkYYLVRXwlKX7lch1QFC0TkIUP8ErXakyw8cHvwIL29/TBxbZPZEUH
	 Lq64zpE8bI48AzpfhOl5uT5iqpe5PIQkGFE3m4LPxVnUUMWPt1DTxqLIKYtO0mw+Sc/2G4Mw4dMA
	 wHxGNKoFNLQT0ABNwGIdqWZX5chb8W+VpAVK7zpg94dXOuutJhxZNgrtNpL5nGJhzdUt54OZbMga
	 K+I6VU/YydhKuXKT/9e9BlcBfHdUXWhOkdXDs2U+0g/2W3I0OQdDAv5R1dX0F8gYjUxnEJID2smq
	 ohnB/DlKMrSzR6UMxlWEpkEUZjwULm
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
To: hsiangkao@linux.alibaba.com
Subject: Re: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
Date: Sun, 31 Dec 2023 10:32:24 +0800
X-OQ-MSGID: <20231231023223.3143138-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
References: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Edward Adam Davis via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, eadavis@qq.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, 31 Dec 2023 09:14:11 +0800, Gao Xiang wrote:
> > When LZ4 decompression fails, the number of bytes read from out should be
> > inputsize plus the returned overflow value ret.
> >
> > Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   fs/erofs/decompressor.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 021be5feb1bc..8ac3f96676c4 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
> >   		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
> >   			       16, 1, src + inputmargin, rq->inputsize, true);
> >   		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
> > -			       16, 1, out, rq->outputsize, true);
> > +			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
> > +			       (ret + rq->inputsize) : rq->outputsize, true);
> 
> It's incorrect since output decompressed buffer has no relationship
> with `rq->inputsize` and `ret + rq->inputsize` is meaningless too.
In this case, the value of ret is -12. 
When LZ4_decompress_generic() fails, it will return "return (int) (- ((const char *) ip) - src) -1;"

Therefore, it can be clearly stated that the decompression has been carried out
to the 11 bytes of src, so reading the value of the first 11 bytes of out is 
effective. Therefore, my patch should be more accurate as follows:
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
+			       (0 - ret) : rq->outputsize, true);
> 
> Also, the issue was already fixed by avoiding debugging messages as
> https://lore.kernel.org/r/20231227151903.2900413-1-hsiangkao@linux.alibaba.com
This just deleted the output.

BR,
Edward

