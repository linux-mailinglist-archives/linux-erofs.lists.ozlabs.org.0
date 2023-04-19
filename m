Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217D6E75FB
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 11:05:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q1Zcg02D4z3fJd
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 19:05:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q1ZcW4g7Wz3f96
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Apr 2023 19:04:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VgUIrAS_1681895094;
Received: from 30.97.48.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgUIrAS_1681895094)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 17:04:55 +0800
Message-ID: <34f622d6-2bd0-9b64-013f-925df8e90077@linux.alibaba.com>
Date: Wed, 19 Apr 2023 17:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs-utils: xattr: skip NFSv4 xattrs building
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Weizhao Ouyang <o451686892@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230419085609.6601-1-o451686892@gmail.com>
 <c2ee08b3-1f6c-3fef-28a0-6b31ed1957d4@linux.alibaba.com>
In-Reply-To: <c2ee08b3-1f6c-3fef-28a0-6b31ed1957d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/19 17:03, Gao Xiang wrote:
> Hi Weizhao,
> 
> On 2023/4/19 16:56, Weizhao Ouyang wrote:
>> Skip NFSv4 xattrs(system.nfs4_acl/dacl/sacl) to avoid ENODATA error when
>> compiling AOSP on NFSv4 servers.
>>
>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> Thanks for the catch! Could we ignore any prefixes
> with identified "system." (but a print warning might be needed...)?

        ^ sorry, unidentified

> 
> Thanks,
> Gao Xiang
> 
> 
>> ---
>>   lib/xattr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 6034e7b6b4eb..748bf2e13408 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -288,6 +288,9 @@ static bool erofs_is_skipped_xattr(const char *key)
>>       if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
>>           return true;
>>   #endif
>> +    /* skip xattr nfs4_acl/dacl/sacl */
>> +    if (!strncmp(key, "system.nfs4_", strlen("system.nfs4_")))
>> +        return true;
>>       return false;
>>   }
