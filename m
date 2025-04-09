Return-Path: <linux-erofs+bounces-180-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88903A834DD
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 01:57:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZY0Gw1tJzz305v;
	Thu, 10 Apr 2025 09:56:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744243016;
	cv=none; b=DxLBq5OprWDVOOrakSq3TcvQyFD/AsJGkvcwwssHPW+B3w41PwNTGe14l0dqGCSbyHD5JVIkAah2J6y321TKpJhxMuYNyyb37a8ytivTC756PgdN6B5iAUlUlZeUHCN8NnCoAKjatWvT+ZYxBDEVOKn3u4cGkhY0idTSDLfbqgbmnU6GlXEXckmTTnmGiDCPYJO/5yYDY8Lg67i+lyvXs6h1es7leNfpBwm+7e3qOVhkFlMWns/2HjfKW2dWoXw0RLp0vMzKOXnybL5audmlvE5wc6DH0rsllgrX92vO2sNUCi42RoVXiLw/YQvPzYWI8BI27GlSMidTW0dZPw+oCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744243016; c=relaxed/relaxed;
	bh=Aoq6JYCaV1p9yraciQnzm7D38594vGRZlTcVPXdUJs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4PQ2n9Md+b6HjYKZyBLe9Cim8XmfseHuVkwP/A/i6qrPTCGmKHX5pXKEL0ak4yeM9IsXr84ipLlEe023nxniOKC8umgNhrTbTxhcDcTx2G9duW1xvVAohuahIdYIrTY+SdIvt7IpW5KsGeNintKLow3XatyrMx9EliIa59ge+HhD7dm5TDFtC6yxFbqE5rjW2AKHzIgK8NJjPld/TomaIsPstmLdG4lI4wVoh0DVacKzSKtBR/X9PqscwEJ8bKscMLkkQbl6voHTXIvvJSVThZiBR1pg7rFAh5QE4qFbfdbKMpr1BF8vcXOhekO0GYrC8tZrwl93wOvMq3uydzBcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xioj6Bbo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xioj6Bbo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZY0Gt4QJnz2y92
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 09:56:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744243009; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Aoq6JYCaV1p9yraciQnzm7D38594vGRZlTcVPXdUJs8=;
	b=Xioj6Bbo71r4nQHT40k9TzdYci02/ewVcJ92B6cVv3807jZcUx44Rk7RpG6ro5NWMHobF7QOwMT8g5Alw9JXbBN8MYHjsHgQ4tXmeGe+CHEn/TCJWIlR6KHYdcqEaoKA95Qt0MEeI2UtvvVINjEXWJSu/JLQ509XEwOm/DniS00=
Received: from 30.134.5.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWLx0T9_1744243006 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 07:56:46 +0800
Message-ID: <7af3e868-04cb-47b1-a81b-651be3756ec5@linux.alibaba.com>
Date: Thu, 10 Apr 2025 07:56:45 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: add __packed annotation to union(__le16..)
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
 <20250409195222.4cadc368@pumpkin>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250409195222.4cadc368@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi David,

On 2025/4/10 02:52, David Laight wrote:
> On Tue,  8 Apr 2025 19:44:47 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> I'm unsure why they aren't 2 bytes in size only in arm-linux-gnueabi.
> 
> IIRC one of the arm ABI aligns structures on 32 bit boundaries.

Thanks for your reply, but I'm not sure if it's the issue.

> 
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/r/202504051202.DS7QIknJ-lkp@intel.com
>> Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
>> Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/erofs_fs.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>> index 61a5ee11f187..94bf636776b0 100644
>> --- a/fs/erofs/erofs_fs.h
>> +++ b/fs/erofs/erofs_fs.h
>> @@ -56,7 +56,7 @@ struct erofs_super_block {
>>   	union {
>>   		__le16 rootnid_2b;	/* nid of root directory */
>>   		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
>> -	} rb;
>> +	} __packed rb;
>>   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
>>   	__le64 epoch;		/* base seconds used for compact inodes */
>>   	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
>> @@ -148,7 +148,7 @@ union erofs_inode_i_nb {
>>   	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
>>   	__le16 blocks_hi;	/* total blocks count MSB */
>>   	__le16 startblk_hi;	/* starting block number MSB */
>> -};
>> +} __packed;
> 
> That shouldn't be necessary and will kill performance on some systems.
> The 'packed' on the member should be enough to reduce the size.

It cannot be resolved by the following diff:

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 94bf636776b0..1f6233dfdcb0 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -148,14 +148,14 @@ union erofs_inode_i_nb {
         __le16 nlink;           /* if EROFS_I_NLINK_1_BIT is unset */
         __le16 blocks_hi;       /* total blocks count MSB */
         __le16 startblk_hi;     /* starting block number MSB */
-} __packed;
+};

  /* 32-byte reduced form of an ondisk inode */
  struct erofs_inode_compact {
         __le16 i_format;        /* inode format hints */
         __le16 i_xattr_icount;
         __le16 i_mode;
-       union erofs_inode_i_nb i_nb;
+       union erofs_inode_i_nb i_nb __packed;
         __le32 i_size;
         __le32 i_mtime;
         union erofs_inode_i_u i_u;
@@ -171,7 +171,7 @@ struct erofs_inode_extended {
         __le16 i_format;        /* inode format hints */
         __le16 i_xattr_icount;
         __le16 i_mode;
-       union erofs_inode_i_nb i_nb;
+       union erofs_inode_i_nb i_nb __packed;
         __le64 i_size;
         union erofs_inode_i_u i_u;

I doesn't work and will report

In file included from <command-line>:
In function 'erofs_check_ondisk_layout_definitions',
     inlined from 'erofs_module_init' at ../fs/erofs/super.c:817:2:
./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct erofs_inode_compact) != 32
   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |

> 
> I'd add a compile assert (of some form) on the size of the structure.

you mean

@@ -435,6 +435,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
         };

         BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
+       BUILD_BUG_ON(sizeof(union erofs_inode_i_nb) != 2);
         BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);

?


./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(union erofs_inode_i_nb) != 2
   542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                      ^

That doesn't work too.

Thanks,
Gao Xiang

