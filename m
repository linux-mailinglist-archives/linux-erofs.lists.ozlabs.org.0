Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFDA2BE8E
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 09:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1738918632;
	bh=SbOffeF1isDuQzmS3E/ZmKSxl+RhpUSblAALzu0XlLs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EEX+OUCOg/baEUWlDGgquwaxpaLDn8gJoYzCK2Rx7OUQq8LI7W6zMY31NVc+xptfQ
	 t/blqE43DO5vxkdbbpUnE3W2hcSHnTpOeGKYQ16d+gXp7ppdDeUQQoGGgThtIcHg60
	 G34h5pcKKpuSDVb2d02neuEu9ljxgb8XX83CztNXD91t4ojBCdvQ+EFtWFrtG8AfGK
	 N/N3eEC6LS1y3Q/X2XQtlSfEx2rF44Y1K+fL8aYx4juivZxagTfysijDZvnZvYv1m5
	 crIEQ7lK01d0ScjoCqbANSi9O8bINm2HBPlEPcNhdUb4Velfys5QfaBGZ5KJzyTZBJ
	 zrxWm8PfGblAg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq7Bw3krhz30VJ
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 19:57:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738918631;
	cv=none; b=RVd7LQkkhJN8IYkl8NWU7SeDK2BjcO3BVamKg9ON08lv/EUushX6FlhNI2gxKI6Z9XOWI+yTfYWEQ9uPKeEj3wJWotwpv3siQCcFZBv3OawpaC8v6Ti8QK9vkbtTXUxF7CLXf7gZFDTF7KRTagHa7l/LnGmkv3C0uY0dC521jUfIBPDwINLQJxGGA93L93i9Dpk85HWdB9xwzXiTOgANlZbPmBQKdyXh2D4JFdhf2CwhI+GmGbpOflqRoJ4bvnec89CAKngHZ+P3nWgmRv8AlL4sxQ9urN2TCRv0LIdT5Of9arLn2lD0znwIKQvWX/r+niZcIYl8dFDpud9f+atSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738918631; c=relaxed/relaxed;
	bh=SbOffeF1isDuQzmS3E/ZmKSxl+RhpUSblAALzu0XlLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jPW6t7SNfXQ/pjtby7PhBsvOVBQ32UP8iFCmoNhxudbavWv/VU7dx2idZLSg2FEmsihcqqVdqhmNs7AskMhy5SFGs+DXDrdYu9PS0OpZTNYomWjML/H5uMtiddfeYubsBEAZHCH5h4g8oAvKdrRHsKFDwvCk9e5LitbCX7wrZcXI692z02NxvGJeoBZGdd7snwPcESSM1O1Z0d3GrmMRl08TJmLQQfyuPExMlGh/gKERiYfCChAlEQRqEG6WY2k/bqBrNUkRMVofu77is7khStBV8yMdbw4pESJVBpxKKCJzzbrdv1PU4w24gjbNQMgAVhz8+jmuvFjmP/iFc775Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq7Bs4gzMz2y66
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 19:57:09 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yq75k1MmVz1W5D8;
	Fri,  7 Feb 2025 16:52:42 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BB7A140257;
	Fri,  7 Feb 2025 16:57:02 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 16:57:02 +0800
Message-ID: <10e648ae-7e0b-4560-a73d-b728efbc9e15@huawei.com>
Date: Fri, 7 Feb 2025 16:57:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongzhen Luo
	<hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250207080829.2405528-1-hongzhen@linux.alibaba.com>
 <f4319592-df8f-4468-b8fb-7fcbc51804c6@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <f4319592-df8f-4468-b8fb-7fcbc51804c6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/7 16:29, Gao Xiang wrote:
> 
> 
> On 2025/2/7 16:08, Hongzhen Luo wrote:
>> There's no need to enumerate each type.  No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> Changes since v1: Put the exception branch at the beginning.
>>
>> v1: 
>> https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/zmap.c | 65 +++++++++++++++++++++----------------------------
>>   1 file changed, 28 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..f65c76991e02 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,23 +265,22 @@ static int z_erofs_extent_lookback(struct 
>> z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>> -        switch (m->type) {
>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> +                  m->type, lcn, vi->nid);
>> +            DBG_BUGON(1);
>> +            return -EOPNOTSUPP;
>> +        }
>> +
>> +        if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>>               lookback_distance = m->delta[0];
>>               if (!lookback_distance)
>>                   goto err_bogus;
>>               continue;
>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +        } else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
> 
> 
> Just `} else {` here?
> 
>>               m->headtype = m->type;
>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>               return 0;
>> -        default:
>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> -                  m->type, lcn, vi->nid);
>> -            DBG_BUGON(1);
>> -            return -EOPNOTSUPP;
>>           }
>>       }
>>   err_bogus:
>> @@ -329,35 +328,31 @@ static int 
>> z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>>       DBG_BUGON(lcn == initial_lcn &&
>>             m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>> -    switch (m->type) {
>> -    case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +        erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", 
>> lcn, vi->nid);
>> +        DBG_BUGON(1);
>> +        return -EFSCORRUPTED;
>> +    }
> 
> No, I don't think it's equivalent, please use
> the previous version for this part instead.

I think this version doesn't consider the fallthrough case. May be just 
use the goto statement can keep equivalent.

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang
