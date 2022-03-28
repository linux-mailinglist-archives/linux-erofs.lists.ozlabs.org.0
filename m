Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4434E8C80
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 05:15:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRd9x5gKYz3c1d
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 14:15:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.13;
 helo=out199-13.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com
 [47.90.199.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRd9s0qDBz2ynk
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Mar 2022 14:15:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8KfeNU_1648437319; 
Received: from 30.225.24.93(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8KfeNU_1648437319) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 28 Mar 2022 11:15:21 +0800
Message-ID: <21126dc4-2b15-bb12-d4d3-b8703be95539@linux.alibaba.com>
Date: Mon, 28 Mar 2022 11:15:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v6 15/22] erofs: register cookie context for bootstrap blob
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-16-jefflexu@linux.alibaba.com>
 <YkElyeMDdt3hQKGi@B-P7TQMD6M-0146.local>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YkElyeMDdt3hQKGi@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/28/22 11:04 AM, Gao Xiang wrote:
> On Fri, Mar 25, 2022 at 08:22:16PM +0800, Jeffle Xu wrote:
>> Registers fscache_cookie for the bootstrap blob file. The bootstrap blob
>> file can be specified by a new mount option, which is going to be
>> introduced by a following patch.
>>
>> Something worth mentioning about the cleanup routine.
>>
>> 1. The init routine is prior to when the root inode gets initialized,
>> and thus the corresponding cleanup routine shall be placed inside
>> .kill_sb() callback.
>>
>> 2. The init routine will instantiate anonymous inodes under the
>> super_block, and thus .put_super() callback shall also contain the
>> cleanup routine. Or we'll get "VFS: Busy inodes after unmount." warning.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/internal.h |  3 +++
>>  fs/erofs/super.c    | 17 +++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 459f31803c3b..d8c886a7491e 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -73,6 +73,7 @@ struct erofs_mount_opts {
>>  	/* threshold for decompression synchronously */
>>  	unsigned int max_sync_decompress_pages;
>>  #endif
>> +	char *tag;
>>  	unsigned int mount_opt;
>>  };
>>  
>> @@ -151,6 +152,8 @@ struct erofs_sb_info {
>>  	/* sysfs support */
>>  	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>>  	struct completion s_kobj_unregister;
>> +
>> +	struct erofs_fscache *bootstrap;
> 
> the concept of bootstrap is nydus-specific. Actually here we need
> a fscache context of the primary device.
> 
> So I prefer struct erofs_fscache *s_fscache;
> 
> Also please help revise the subject and commit message about
> bootstrap.
> 

OK, will be done in the next version.


-- 
Thanks,
Jeffle
