Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144C4DD45C
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 06:27:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKXZK64Stz30Dv
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 16:27:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKXZG4tQ7z2yPv
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 16:27:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7UqACk_1647581210; 
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7UqACk_1647581210) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Mar 2022 13:26:51 +0800
Message-ID: <ce8a179d-db54-d787-dc89-1a8d4de32c14@linux.alibaba.com>
Date: Fri, 18 Mar 2022 13:26:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH v5 10/22] erofs: add mode checking helper
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org, gregkh@linuxfoundation.org,
 tao.peng@linux.alibaba.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-11-jefflexu@linux.alibaba.com>
 <YjLI0cCcxtg/rEHj@B-P7TQMD6M-0146.local>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjLI0cCcxtg/rEHj@B-P7TQMD6M-0146.local>
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



On 3/17/22 1:36 PM, Gao Xiang wrote:
> On Wed, Mar 16, 2022 at 09:17:11PM +0800, Jeffle Xu wrote:
>> Until then erofs is exactly blockdev based filesystem. In other using
>> scenarios (e.g. container image), erofs needs to run upon files.
>>
>> This patch set is going to introduces a new nodev mode, in which erofs
>> could be mounted from a bootstrap blob file containing complete erofs
>> image.
>>
>> Add a helper checking which mode erofs works in.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/internal.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index e424293f47a2..f66af9ebda43 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -161,6 +161,11 @@ struct erofs_sb_info {
>>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
>>  #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
>>  
>> +static inline bool erofs_bdev_mode(struct super_block *sb)
> 
> How about renaming it as erofs_is_nodev_mode()?

Sure, will be renamed in the next version.


-- 
Thanks,
Jeffle
