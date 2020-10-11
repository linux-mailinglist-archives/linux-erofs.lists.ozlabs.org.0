Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129928A671
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Oct 2020 10:59:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C8G2Q1dt3zDqty
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Oct 2020 19:59:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602406750;
	bh=mP0c+ZJzpC8cvPE9q7N/M1NLwX2NjncyP9KIhfNRp4s=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VHfiSNV+2MyVHgaaOttMXDhKgr5atf0PyK+YwoqEGFb3WPtDDieQzSCszugrQVoAm
	 K7EAZWLj6Gzv1qtSafG9OmzDJmM15BA39Ta37q6oCy4KI/EsoqXsLVOrm0G/i3frUr
	 OOBhJGE41MNiVdcHJiDNV/i//amt4Hr11KpGAKkBI8xTETlNDz5i0+aUelt5+ptSnX
	 M4khvSZQShGQN8Z6ULwAh4COKHU4BBUVBk8cA1yTvoOD7MpsQ7WrVytVntRw0hdD+w
	 oDE2Br8OyjVdrbOO3P1Lb7SJVnQQze3oubLYQgOMG7k3uHknQzaAc+Kf6pmzmLVa4e
	 eoFP73P2c7E9A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.53;
 helo=out30-53.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=I5TSBE4q; dkim-atps=neutral
Received: from out30-53.freemail.mail.aliyun.com
 (out30-53.freemail.mail.aliyun.com [115.124.30.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8G243ZBZzDqsq
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Oct 2020 19:58:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1602406726; h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type;
 bh=SSsyIVyMf6nZUoewhFEfRBjipFDJJRBxYGjs4B6T2d4=;
 b=I5TSBE4qR+UFYQIg788rZJfWT+NAD+JrgZwmY3N6hhVH3q20mYLlS2Vqxv2EcjMDpUs8ej2T+BYxvcqXz2aVBHtiU18MlGoP2VTgEZzN+atd/oq5AfIV1H81Y0XJXHXxT32QZVFRPuDPrncK0gFEtoTKJ9YzfbuqY9hAPrjtGYQ=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1032649|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00537778-0.000560787-0.994061;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UBdjjjE_1602406403; 
Received: from 192.168.3.5(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UBdjjjE_1602406403) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 11 Oct 2020 16:53:23 +0800
Subject: Re: [PATCH v2] AOSP: erofs-utils: add fs_config support
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20200928213549.17580-1-hsiangkao@aol.com>
 <20200929051302.3324-1-hsiangkao@aol.com>
 <7e4490c0-0a3d-0ceb-98ca-73d5eb69932d@aliyun.com>
Message-ID: <a4b4d4a8-46bc-87d2-eb8a-d1d010f9d76d@aliyun.com>
Date: Sun, 11 Oct 2020 16:53:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <7e4490c0-0a3d-0ceb-98ca-73d5eb69932d@aliyun.com>
Content-Type: text/plain; charset=gbk
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2020/10/10 0:33, Li GuiFu 写道:
> 
> 
> 在 2020/9/29 13:13, Gao Xiang 写道:
>> So that mkfs can directly generate images with fs_config.
>> All code for AOSP is wraped up with WITH_ANDROID macro.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>> ---
>> changes since v1:
>>  - fix compile issues on Android / Linux build;
>>  - tested with Android system booting;
>>
>>  include/erofs/config.h   | 12 ++++++++++
>>  include/erofs/internal.h |  3 +++
>>  lib/inode.c              | 49 +++++++++++++++++++++++++++++++++++++
>>  lib/xattr.c              | 52 ++++++++++++++++++++++++++++++++++++++++
>>  mkfs/main.c              | 29 +++++++++++++++++++++-
>>  5 files changed, 144 insertions(+), 1 deletion(-)
>>
Please update the usage about mount-point

