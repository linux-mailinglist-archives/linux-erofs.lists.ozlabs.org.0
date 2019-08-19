Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E894F3F
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 22:45:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46C5Xs6G2LzDqlB
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 06:45:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566247533;
	bh=MZGZIE2qcM48nQg8Do/w8LvOPil+WmCb3kE94fja31M=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YoFttkqErGBOjrti23dtyM6ekwxHmo13pzBfDxgxu2jQFRLWDop8GxXBgk9oQ4lGi
	 cHEIok7oKqIs16WwZ0xsuCien9sqGOMf9Uocshf1W9ldbSqMcKtMialOIi9/dETwJM
	 pejTuSHrrP9jwUZD2vZMBfjKKpAacYj2hKqFN5G42nEPErL4bd/OgwM2IfhgLeRmFW
	 D4/bXKPcQ778UStuHVbURQvIZ6hUzV72HOtpkm7uJ1me2JGbmpjZI1vwB5+NXQQXs0
	 y45z/Awy0MGaQDz78UjL0CHbBml+enHKO+L4NGUYvS/z8+qpAijA5tTevjvHfiD/MD
	 qMLm6MnMxi2LA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="iMv/2qUZ"; 
 dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46C5Xf5jh2zDqXS
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 06:45:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566247513; bh=/FjyeBf66fBZlR8Gaqo2Oupc6SxE7IKBQvqIGSvJQNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=iMv/2qUZXCZBDhq8bD3TkgK5G7xiq8jYuD4xJuM0CVldIsTESdO23NRqKZ6P8QwQJ/hTXgML5tcdekiTJrVRuIV1LwbbfTkLFGSh76d+LzZALNd/sjyVcpKUoNCJPawsypqvvaViwP5HlC8Eo9BDyJkT5ZTUUoaklkgzh0qUtzT3b1aIVqEYIJF98Nm8MoSjLm6bLaekitNhRqdw/p1rHLCna6pYKVqLs6k3/s1Z/+PA6lO+uWbASymxyYEvAcn5usVrAd683oh8AtFsZxJGcPLbqOgT7B9b6dsVflHUvJxB3gE4AGbDourmwHzgvPiIiqH8ATi7chRSUwibkvNgvA==
X-YMail-OSG: tqQ4ci4VM1n4wfQKEzqsIBEQfIquIcCUir4PEXZ3SDMJZCBPhJtiyrs1uRQx67t
 p4PjzGg4sYUNobwg5ner2opFh1xd0plGWLbRz6Qq6Qv0LilmB4863tOx1kXM5FnwnQssP6ANKwNS
 bfZQJW05._jlPalhRvnNYk3QYgEoxSeCV5zaAVO5hnMP0KhAHpYEr8gev9w4Lxs92dFXFp.ePcEW
 KHrR3MAIxp.EJC2LsyWF7PgiLEmcOYssgsON_pBFUQU8DuYBpG5QbjuBILOoMiJ3n2it6BwwqsEy
 v5_iuyD1GUpQLhH9k_dBGh4K7ZHPcsk0TeaRLpt46.4RA6VzLJIaQtrqwXC3ZapZ3K06Au7bILsB
 nD3eqmb5YOhkf3O51nZHPG_ByYXSOp4cKpkag9EflPAaqXDj5m8TLs03qd0PzfqrKE9INxAMG9Vg
 lEa0Jz.3g55seeIMxiAhfZzsGCa83ssFbPcIRl7qF4wkQrDzjYoBNxZzKuZ2FR95qN0RqsjprlsC
 BvyGErjN.jJGKZ2zteWT0tNV0Dm1FaLFLve7XaJNsTOfx4RV4flbq4l1Ddu_K5pTCLKDmgSfkR_m
 0ZDLrgw.Y58lyH5VPwOfd7a4GkS3TZITQkF2gVN1n1if5s8fjMa2y4Fr3gpBAjRnCobXLNJ5pnZh
 PIjqluAKUdxOdxcu2rh2BN3jWejala18QxQoQ59C0PHTX7GfH9hGEqtYAkpF9fKKt.QaeoAdF_Z5
 aKC_RlWxtggq__y2.7_3YztAGMAmGupB9stVmfL.FBr5ri6HBBy7jYg92wJDNj3hPTJG14LkGpDH
 HwKWzYbBXj9YpARUsbrpxoDYagTk0LCoLMvXJxqSxIl6KrSzRZa4WTAGCWq4K.E9osQgFqP.Fvdm
 HYbwPbZQDvCyykJN4EGyL6CsBuZnoif0SBJbxu4cHSa1lFM0OxvuqXzs9iSFIrOtDacTskJiO126
 KoXZZKCjH2AW3Vqwm7vUoVDAx.YMJcQCFO8zrJUCrW3NbiS4M7lRXCk1eDVtOgMO2lprg_GkE0T9
 kKzMwNgS0R0E818h_gvx60LaCRyiFnmJKWCC.iRA0FHbveGLL02xNsNToezK_1OrN9jUPg3TtqfH
 IjBW_m.B9_FFE8NKAXNffEWHkbd2hb9FPPQOJhcrCJEmz0YyQ1WP6_vN7VXC97laT9lYGlL2QiQM
 hfJKsli7.MTTYQ76DEs2VRhRQpRbOJjKgE9r7axRCOb7pV19B3m0s4pRSk21gJB.PP8dh4_AfQh1
 6I9QYgXkTO71tlERe.dY4bg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Aug 2019 20:45:13 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d4e306b9ca70839f217535bade4a91d7; 
 Mon, 19 Aug 2019 20:45:12 +0000 (UTC)
Date: Tue, 20 Aug 2019 04:45:08 +0800
To: Richard Weinberger <richard@nod.at>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Richard,

On Mon, Aug 19, 2019 at 07:10:33PM +0200, Richard Weinberger wrote:
> Hi!
> 
> struct erofs_super_block has "checksum" and "features" fields,
> but they are not used in the source.
> What is the plan for these?

Yes, both will be used laterly (features is used for compatible
features, we already have some incompatible features in 5.3).

> 
> Same for i_checksum in erofs_inode_v1 and erofs_inode_v2.

checksum field apart from super_block has been reserved again
for linux-next. checksum in the super_block still exists and
will be used sooner.

The reason I discussed with Chao is
since EROFS is a read-only filesystem, we will develop block-based
checksum and integrity check to EROFS in the future version. It's
more effectively than adding such fields to all metadata (some metadata
is too large, we cannot calculate a checksum for the whole metadata
and compare at runtime, but we can do block-based metadata chksum
since EROFS is a read-only fs).

> 
> At least the "features" field in the super block is something I'd
> expect to be used.
> ...such that you can have new filesystem features in future.

Of course, "features" is for compatible features, "requirements" is
for incompatible features. Both will be used in the future.

Thanks,
Gao Xiang

> 
> Thanks,
> //richard
