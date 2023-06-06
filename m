Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE97238E3
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 09:23:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qb24s5l1bz3chN
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 17:23:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686036189;
	bh=LnGDaaPpwu+yqeK/u8WKc7CvnWM+eEAgxUR05ee/p/s=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=eVXGfo43DgYzGbgHMu/bnPs5lA0cwOi1uueKML1fGF86FF4oYhkf3vmGs7I8itHyr
	 9sKxrPHB/f41wAnYfWzLXSFu9ju9l1hem4tYxWHLiwujRSR9rUdotgFppZmWiInQFx
	 LtpvnMhH78pBGh8TDrN7MYLn4iciHXgdiqT0aqV5kSlT7SEhp54txNrckVpFrescx9
	 jUwZ/MaRmeElV4KdJ/jyZ0SgfcBBDyMp0vJSOMkCb2m8GIdOee3r4zaBdrYEsz/g0c
	 0V0reHMJ1ui4aXVQBIzxmeH1Lo0JB1WXiSHPRQuQ3hHREF2tT396Lh7zVe5jw1lXlL
	 BGsafDV5nYhhg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
X-Greylist: delayed 976 seconds by postgrey-1.36 at boromir; Tue, 06 Jun 2023 17:23:02 AEST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qb24k3Wmhz3f5c
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 17:23:01 +1000 (AEST)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb1bh3P4GzqTml;
	Tue,  6 Jun 2023 15:01:20 +0800 (CST)
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 15:06:06 +0800
Message-ID: <1ee9c095-e472-e96e-77eb-5e3db0bcd20e@huawei.com>
Date: Tue, 6 Jun 2023 15:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] erofs-utils: dump: add some superblock fields display
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20230606035511.1114101-1-guoxuenan@huawei.com>
 <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.238]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
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
Take a look at the currently implemented interface, compressor.c define
different compressors for mkfs.erofs, but for dump.erofs we don't care
about that much, we only show compression algothrims name  the image

Best regards
Xuenan.
> Thanks,
> Gao Xiang
>

-- 
Guo Xuenan [OS Kernel Lab]
-----------------------------
Email: guoxuenan@huawei.com
