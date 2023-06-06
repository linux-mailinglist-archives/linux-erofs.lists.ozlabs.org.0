Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E47723901
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 09:29:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qb2D16zFHz3chV
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 17:29:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qb2Cy14cNz3bkM
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 17:29:16 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qb1zX0DVGz9y9MY
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 15:18:32 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP1 (Coremail) with SMTP id 76C_BwDXbWEt4H5kQDhvCA--.22479S2;
	Tue, 06 Jun 2023 07:28:48 +0000 (GMT)
Message-ID: <c1e01731-9922-e146-2008-b68c22926999@huaweicloud.com>
Date: Tue, 6 Jun 2023 15:28:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From: Guo Xuenan <guoxuenan@huaweicloud.com>
Subject: Re: [PATCH] erofs-utils: dump: add some superblock fields display
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230606035511.1114101-1-guoxuenan@huawei.com>
 <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 76C_BwDXbWEt4H5kQDhvCA--.22479S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fXw4xWr43WrWkJFykAFb_yoW5tw45pr
	1Fyr15JryUJF18Ar1fJr1Utry5Jr18tw1DGr17JF48Jr17Ary2qr12qr1vgryDJrW8WFyU
	Jr1UZr15uw17JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2023/6/6 13:27, Gao Xiang wrote:
> Hi Xuenan,
>
> On 2023/6/6 11:55, Guo Xuenan wrote:
>> dump.erofs show compression algothrims and sb_exslots,
>
>                  ^ algorithms and sb_extslots
>
sorry :P
>> and update feature information.
>>
>> th current super block info displayed as follows:
>
> The proposed super block info is shown as below:
>
>> Filesystem magic number:                      0xE0F5E1E2
>> Filesystem blocks:                            4637
>> Filesystem inode metadata start block:        0
>> Filesystem shared xattr metadata start block: 0
>> Filesystem root nid:                          37
>> Filesystem compr_algs:                        lz4 lzma
>> Filesystem sb_extslots:                       0
>> Filesystem inode count:                       36
>> Filesystem created:                           Tue Jun  6 10:23:02 2023
>> Filesystem features:                          sb_csum mtime 
>> lz4_0padding compr_cfgs big_pcluster
>> Filesystem UUID:                              not available
>>
>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>> ---
>>   dump/main.c              | 34 +++++++++++++++++++++++++++++++++-
>>   include/erofs/internal.h |  1 +
>>   lib/super.c              |  5 +++++
>>   3 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/dump/main.c b/dump/main.c
>> index efbc82b..20e1456 100644
>> --- a/dump/main.c
>> +++ b/dump/main.c
>> @@ -93,13 +93,25 @@ struct erofsdump_feature {
>>   static struct erofsdump_feature feature_lists[] = {
>>       { true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
>>       { true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
>> -    { false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
>> +    { false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "lz4_0padding" },
>
> Better to keep it as is (see kernel code.)
>
Okay, will fix it in v2
>> +    { false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
>>       { false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
>>       { false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
>>       { false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
>>       { false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
>>       { false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
>>       { false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
>> +    { false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
>> +};
>> +
>> +struct available_alg {
>> +    int type;
>> +    const char *name;
>> +};
>
> Could we use lib/compressor.c instead?
>
Take a look at the currently implemented interface, and I notice that
compressor.c define different compressors for mkfs.erofs, but for
dump.erofs we don't need care about that much, we only show compression
  algothrims name of the image. It seems that it cannot be reused.
> Thanks,
> Gao Xiang
>

-- 
Guo Xuenan [OS Kernel Lab]
-----------------------------
Email: guoxuenan@huawei.com

