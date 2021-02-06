Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C0311E6C
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Feb 2021 16:29:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXx6L3GDYzDwlQ
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Feb 2021 02:29:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612625370;
	bh=hgxIN1xz6WNtMS2XX6++ji+mL1lsSUdOLZCakEZ17hI=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=juvrRTMvWNvrZSdDInNmM1q4G83HrjxZOcbBUdsX0QB2O84iJfL2/W6SE8w0ViHSK
	 8ymbdFLQBMaadfrrGo/Gs+FItJbwt04ky+V0kzevWiWtf/mpsR76vc2fyaUX3H5167
	 61dyTsUyJEKmFVK5iKyeFig098mgdeOS17xC3vvFg3xXzblDQvYNINMAyPIz++nO5L
	 3/waUeiSp5ctpJJ6n09i3Ja/eUjdVVvscvV0y01IZZsBqg4Ndjy2YWFFSNvvHZpsw8
	 5FelXQZwU5Hu+bJZMtdpGYWobaVtVDffrwf+HLQ0rN4Vzbe2yxb3atDam/ukZq8+c/
	 ldrV00CbdgM8g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.16;
 helo=out30-16.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=YATxWL4Y; dkim-atps=neutral
Received: from out30-16.freemail.mail.aliyun.com
 (out30-16.freemail.mail.aliyun.com [115.124.30.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXx633dHYzDwjP
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Feb 2021 02:29:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1612625330; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=QSmsTJ+Wv9wEcTFD7i0msaKTG7/aWn89btTxRmrHcOE=;
 b=YATxWL4Y0cNkYo730ez8wDsgCBLqlC277ZsxePKtVr5mY7Rp+BJTUK6CLQIO3BOAnMvQdvGox+00MM2yH3TYLRAosPSGi4QxSgK9KqiO1ngpvhsApC7RspdYoHhAVyhocXvd2tR075hpVPQz0inW2WiCAiMJAE5flmCEPVx0+DU=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1552433|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0270403-0.000693898-0.972266;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UO0t.rd_1612625328; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UO0t.rd_1612625328) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Feb 2021 23:28:48 +0800
Subject: Re: [PATCH v7 1/3] erofs-utils: get rid of `end' argument from
 erofs_mapbh()
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210122171153.27404-1-hsiangkao@aol.com>
 <20210122171153.27404-2-hsiangkao@aol.com>
Message-ID: <0d6fadd3-29ca-2c05-559c-ae5d4e4d9eb4@aliyun.com>
Date: Sat, 6 Feb 2021 23:28:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122171153.27404-2-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/1/23 1:11, Gao Xiang via Linux-erofs wrote:
> From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
> `end` arguement is completely broken now. Also, it could
> be reintroduced later if needed.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  include/erofs/cache.h |  2 +-
>  lib/cache.c           |  6 ++----
>  lib/compress.c        |  2 +-
>  lib/inode.c           | 10 +++++-----
>  lib/xattr.c           |  2 +-
>  mkfs/main.c           |  2 +-
>  6 files changed, 11 insertions(+), 13 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
