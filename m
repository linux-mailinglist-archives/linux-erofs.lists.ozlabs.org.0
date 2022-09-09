Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B285B3404
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 11:32:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP9kP5b1Mz2yPH
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 19:32:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.3; helo=out199-3.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 308 seconds by postgrey-1.36 at boromir; Fri, 09 Sep 2022 19:32:10 AEST
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP9kL2rTLz2yPH
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 19:32:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VP9-qIZ_1662715615;
Received: from 30.221.130.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VP9-qIZ_1662715615)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:26:56 +0800
Message-ID: <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
Date: Fri, 9 Sep 2022 17:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 3/5] erofs: add 'domain_id' prefix when register sysfs
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-4-zhujia.zj@bytedance.com>
 <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
In-Reply-To: <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/9/22 5:23 PM, JeffleXu wrote:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> In shared domain mount procedure, add 'domain_id' prefix to register
>> sysfs entry. Thus we could distinguish mounts that don't use shared
>> domain.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>  fs/erofs/sysfs.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index c1383e508bbe..c0031d7bd817 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
>>  int erofs_register_sysfs(struct super_block *sb)
>>  {
>>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	char *name = NULL;
>>  	int err;
>>  
>> +	if (erofs_is_fscache_mode(sb)) {
>> +		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
>> +				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
>> +				sbi->opt.fsid);
>> +		if (!name)
>> +			return -ENOMEM;
>> +	}
> 
> 
> How about:
> 
> name = erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id;
> if (sbi->opt.domain_id) {
> 	str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
> 	name = str;
> }

Another choice:

if (erofs_is_fscache_mode(sb)) {
	if (sbi->opt.domain_id) {
		str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
		name = str;
	} else {
		name = sbi->opt.fsid;
	}
} else {
	name = sb->s_id;
}




> 
> 
>>  	sbi->s_kobj.kset = &erofs_root;
>>  	init_completion(&sbi->s_kobj_unregister);
>>  	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
>> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>> +			name ? name : sb->s_id);
> 
> 	kobject_init_and_add(..., "%s", name);
> 	kfree(str);
> 
> though it's still not such straightforward...
> 
> Any better idea?
> 
> 
>> +	kfree(name);
>>  	if (err)
>>  		goto put_sb_kobj;
>>  	return 0;
> 

-- 
Thanks,
Jingbo
