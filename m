Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867D3776F7
	for <lists+linux-erofs@lfdr.de>; Sun,  9 May 2021 16:30:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FdRRp1cRbz2ykP
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 00:30:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1620570630;
	bh=SFDPjp32b5wv4OiCpxmorjkTz172DieBRRlEKxZYqu8=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=caIg0NcLrZ6PcSKsIvtwihYDum/sJlLPh4MddbYaTHaUtzRB44pdm0ELRf4DqL6tI
	 VDxY3kaQrtk++8UfjeiRFvEGfSARHUbR9L3FxapMzXrMXdzRJykWjLlpFXaJc/YsMP
	 8SikCaks/gs8Wqa9jQ4YDGhDp4jn7ghk5Wdh/IeO7qYC9twzrsb60Sne9/ebhGP07Y
	 etiDEu4JPMnoAG0Eywu462ksupJkJPDc2ncZJkByDo7stjoY8jWBXuUF1XWF29Jxrj
	 KvcHncWz8JvBUEq1+doAMjSkzlVWU/a5h3XqPqPhgJ2zgDNZ7h37AnWHbQdTEkanC6
	 mrrfvZ8Z3HPXA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.52;
 helo=out30-52.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=mluoWkkn; dkim-atps=neutral
Received: from out30-52.freemail.mail.aliyun.com
 (out30-52.freemail.mail.aliyun.com [115.124.30.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdRRj42qmz2yXT
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 00:30:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357807|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.230822-0.00907311-0.760105;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04395; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UYFpJIH_1620570606; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UYFpJIH_1620570606) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 09 May 2021 22:30:07 +0800
Subject: Re: [PATCH v1 2/2] erofs-utils: introduce erofs_subdirs to one dir
 for sort
To: Gao Xiang <xiang@kernel.org>
References: <20210505142615.38306-1-bluce.lee@aliyun.com>
 <20210505142615.38306-2-bluce.lee@aliyun.com>
 <20210507070958.GA8929@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <aa2954c6-442b-86e2-5f0e-27dad4026ff1@aliyun.com>
Date: Sun, 9 May 2021 22:30:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210507070958.GA8929@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

GaoXiang

On 2021/5/7 15:09, Gao Xiang wrote:
> Hi Guifu,
> 
> On Wed, May 05, 2021 at 10:26:15PM +0800, Li Guifu via Linux-erofs wrote:
>> The structure erofs_subdirs has a dir number and a list_head,
>> the list_head is the same with i_subdirs in the inode.
>> Using erofs_subdirs as a temp place for dentrys under the dir,
>> and then sort it before replace to i_subdirs
>>
>> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
>> ---
>>  include/erofs/internal.h |  5 +++
>>  lib/inode.c              | 95 +++++++++++++++++++++++++---------------
>>  2 files changed, 64 insertions(+), 36 deletions(-)
>>
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index 1339341..7cd42ca 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -172,6 +172,11 @@ struct erofs_inode {
>>  #endif
>>  };
>>  
>> +struct erofs_subdirs {
>> +	struct list_head i_subdirs;
>> +	unsigned int nr_subdirs;
>> +};
>> +
>>  static inline bool is_inode_layout_compression(struct erofs_inode *inode)
>>  {
>>  	return erofs_inode_is_data_compressed(inode->datalayout);
>> diff --git a/lib/inode.c b/lib/inode.c
>> index 787e5b4..3e138a6 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -96,7 +96,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>>  	return 0;
>>  }
>>  
>> -struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>> +struct erofs_dentry *erofs_d_alloc(struct erofs_subdirs *subdirs,
>>  				   const char *name)
>>  {
>>  	struct erofs_dentry *d = malloc(sizeof(*d));
>> @@ -107,7 +107,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>>  	strncpy(d->name, name, EROFS_NAME_LEN - 1);
>>  	d->name[EROFS_NAME_LEN - 1] = '\0';
>>  
>> -	list_add_tail(&d->d_child, &parent->i_subdirs);
>> +	list_add_tail(&d->d_child, &subdirs->i_subdirs);
>> +	subdirs->nr_subdirs++;
>>  	return d;
>>  }
>>  
>> @@ -150,38 +151,12 @@ static int comp_subdir(const void *a, const void *b)
>>  	return strcmp(da->name, db->name);
>>  }
>>  
>> -int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
>> +int erofs_prepare_dir_file(struct erofs_inode *dir)
> 
> Err... nope, that is not what I suggested, I was suggesting
> 
> int erofs_prepare_dir_file(struct erofs_inode *dir,
> 			   struct erofs_subdirs *subdirs)
> 
>>  {
>> -	struct erofs_dentry *d, *n, **sorted_d;
>> -	unsigned int d_size, i_nlink, i;
>> +	struct erofs_dentry *d;
>> +	unsigned int d_size, i_nlink;
>>  	int ret;
>>  
>> -	/* dot is pointed to the current dir inode */
>> -	d = erofs_d_alloc(dir, ".");
>> -	d->inode = erofs_igrab(dir);
>> -	d->type = EROFS_FT_DIR;
>> -
>> -	/* dotdot is pointed to the parent dir */
>> -	d = erofs_d_alloc(dir, "..");
>> -	d->inode = erofs_igrab(dir->i_parent);
>> -	d->type = EROFS_FT_DIR;
> 
> Leave these two here, since it's a part of dir preparation.
I think  this erofs_prepare_dir_file() funtion just do space prepare
that  dirs have been sorted before

. and .. should been added along with readir


