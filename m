Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E99B638556
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 09:40:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJSwl4Jqbz3cd2
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 19:40:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJSwg1Rmdz3c2j
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Nov 2022 19:40:00 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NJSwN15kHz4f3rRw
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Nov 2022 16:39:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDX7rlTf4Bj6OBvBA--.21626S2;
	Fri, 25 Nov 2022 16:39:50 +0800 (CST)
Subject: Re: [External] [PATCH] erofs: check the uniqueness of fsid in shared
 domain in advance
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
References: <20221125074057.2229083-1-houtao@huaweicloud.com>
 <49b2b8e4-39d0-983c-23c6-f18232a7dff3@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <86bf6991-d46b-be95-06a7-87829e8c5e33@huaweicloud.com>
Date: Fri, 25 Nov 2022 16:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <49b2b8e4-39d0-983c-23c6-f18232a7dff3@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDX7rlTf4Bj6OBvBA--.21626S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fGF4xKr1fJFW7Ww48JFb_yoW7Jr48p3
	95CryrJrW8Zr1kZw4xXF1UXFy8J34kK3WDGw18Xa4Fyw4UJr10qryjqr1qgF1UGr4kJrW7
	XF1jvw1Uuw17Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 11/25/2022 4:25 PM, Jia Zhu wrote:
> Hi Tao,
> We've noticed this warning during development. It seems not a bug, so
> I ignored that.
> Many thanks for cacthing and clearing up the annoying warning.
Yes, it is not a bug. The duplicated mount will fail with -EEXIST even without
the patch. But it is a bit scary to see such warning in dmesg, so just fix it.
>
> 在 2022/11/25 15:40, Hou Tao 写道:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When shared domain is enabled, doing mount twice with the same fsid and
>> domain_id will trigger sysfs warning as shown below:
>>
>>   sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
>>   CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x38/0x49
>>    dump_stack+0x10/0x12
>>    sysfs_warn_dup.cold+0x17/0x27
>>    sysfs_create_dir_ns+0xb8/0xd0
>>    kobject_add_internal+0xb1/0x240
>>    kobject_init_and_add+0x71/0xa0
>>    erofs_register_sysfs+0x89/0x110
>>    erofs_fc_fill_super+0x98c/0xaf0
>>    vfs_get_super+0x7d/0x100
>>    get_tree_nodev+0x16/0x20
>>    erofs_fc_get_tree+0x20/0x30
>>    vfs_get_tree+0x24/0xb0
>>    path_mount+0x2fa/0xa90
>>    do_mount+0x7c/0xa0
>>    __x64_sys_mount+0x8b/0xe0
>>    do_syscall_64+0x30/0x60
>>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
>> data blob (aka fsid) is unique in the shared domain and
>> erofs_register_sysfs() invoked by the second mount will fail due to the
>> duplicated fsid in the shared domain and report warning.
>>
>> It would be better to check the uniqueness of fsid before doing
>> erofs_register_sysfs(), so adding a new flags parameter for
>> erofs_fscache_register_cookie() and doing the uniqueness check if
>> EROFS_REG_COOKIE_NEED_NOEXIST is enabled.
>>
>> After the patch, the error in dmesg for the duplicated mount would be:
>>
>>   erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
SNIP
>>   diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 05dc68627722..a5f8c8fcdd17 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -604,13 +604,18 @@ static inline int z_erofs_load_lzma_config(struct
>> super_block *sb,
>>   }
>>   #endif    /* !CONFIG_EROFS_FS_ZIP */
>>   +/* flags for erofs_fscache_register_cookie() */
>> +#define EROFS_REG_COOKIE_NEED_INODE 1
>> +#define EROFS_REG_COOKIE_NEED_NOEXIST 2
> How about using TAB to align the columns?
> Apart from this, LGTM.
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Thanks.
Thanks for the review. Will do the alignment in v2.
>> +
>>   /* fscache.c */
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   int erofs_fscache_register_fs(struct super_block *sb);
>>   void erofs_fscache_unregister_fs(struct super_block *sb);
>>     struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>> -                             char *name, bool need_inode);
>> +                            char *name,
>> +                            unsigned int flags);
>>   void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
>>     extern const struct address_space_operations erofs_fscache_access_aops;
>> @@ -623,7 +628,8 @@ static inline void erofs_fscache_unregister_fs(struct
>> super_block *sb) {}
>>     static inline
>>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>> -                             char *name, bool need_inode)
>> +                             char *name,
>> +                             unsigned int flags)
>>   {
>>       return ERR_PTR(-EOPNOTSUPP);
>>   }
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 1c7dcca702b3..481788c24a68 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -245,7 +245,7 @@ static int erofs_init_device(struct erofs_buf *buf,
>> struct super_block *sb,
>>       }
>>         if (erofs_is_fscache_mode(sb)) {
>> -        fscache = erofs_fscache_register_cookie(sb, dif->path, false);
>> +        fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
>>           if (IS_ERR(fscache))
>>               return PTR_ERR(fscache);
>>           dif->fscache = fscache;
> .

