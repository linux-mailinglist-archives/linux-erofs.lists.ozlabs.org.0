Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40411A2BEF9
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 10:16:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq7cy0LJKz30VL
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 20:16:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738919775;
	cv=none; b=i1g3/4enVxyTvlpNAUO9Sk/Q1QP09SBQfFEyBlP1KMFDks/rCOI/j5HezNAQ5Ze+YrSV/Se97zKFUe8KkqLsQUh3jRlKfwVQLEjCyp/uwF4RSHrHXe1ECqSEGeQHR6XF7lZDyIB495juUxmmSzhnX3c7AMAkwsS02+cpGJAKQN399umWKPGTJMmUc6+G9cRYYtQ7PrVSN7y+YXje/PQ4XYgd4F7fie+p5IvOXV6P+rSKAFQQgbJtn48QGLnhax91QWDiUQkzOmQ1nSpz3kbSnUbGGQrIr3l0n6hnjqlY0omrCJiO5cUXRdskwRIxXxEAvdqI22Kn1CJBGxC0+XHqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738919775; c=relaxed/relaxed;
	bh=Grg7rJZW3zRg1SggkVh93MgmqC7Kjg7hdIXpPILem1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQs7SAH872AXeFWieKSFYw+u77h3xa+e+wPBn8EEnwaLeARkSenA4d2cfeOIKSSqKIEl63w1vjD/96uTUcWgBMJ6jQlIQMyghk8oPKuCjFHxd88t9/vFDwLK78DgeoyG5vSH0Ujy0QuiExMspMNS7o3ZER3PWUVlwN15ydU0FWKOnkSoOLvC4FCMY13vnL4MSB4GQOk4C5f8TgaNWtQUY94BTGCM07DoDFPvRYxRC2y4zaLaXi70I8vJBC+AZYBGQvEZ2NPbz1pffyLJLpc8NUc9uVwd2uXGGgjFdfQgZfPHY5AJU7qA9T9l/5cP6EzgBIiVEp/EhmZ4F3Dcnui5PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K5IeC2W9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K5IeC2W9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq7ct2dybz301v
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 20:16:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738919770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Grg7rJZW3zRg1SggkVh93MgmqC7Kjg7hdIXpPILem1Q=;
	b=K5IeC2W9aW/0HL1Hd4v6AulYN20Slmk6gMqX8tmIzZtuhOmltsP/Tp/5cTO7GHWnuo0XqzPSNAsMXRrJUAl5HrZax7uLmWhOP+S65dHnx5ztfU6noUlQ24857yiSEyoPSQfDU0B2wyIUUYA7rvkbHi3m5oMYXnBNHYrZ9fNb5tw=
Received: from 30.221.129.238(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WOyzElj_1738919767 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:16:07 +0800
Message-ID: <7e214f7e-1da8-468a-900d-4d9ee726348b@linux.alibaba.com>
Date: Fri, 7 Feb 2025 17:16:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250207085056.2502010-1-hongzhen@linux.alibaba.com>
 <29c5e464-4a11-42f4-b303-279c4b642471@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <29c5e464-4a11-42f4-b303-279c4b642471@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2025/2/7 17:14, Gao Xiang wrote:
>
>
> On 2025/2/7 16:50, Hongzhen Luo wrote:
>> There's no need to enumerate each type. No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---> v3: Code cleanup, remove logically inequivalent changes.
>> v2: 
>> https://lore.kernel.org/all/20250207080829.2405528-1-hongzhen@linux.alibaba.com/
>> v1: 
>> https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/zmap.c | 60 +++++++++++++++++++------------------------------
>>   1 file changed, 23 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..7dba1573498b 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,23 +265,20 @@ static int z_erofs_extent_lookback(struct 
>> z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>>   -        switch (m->type) {
>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> +                  m->type, lcn, vi->nid);
>> +            DBG_BUGON(1);
>> +            return -EOPNOTSUPP;
>> +        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>>               lookback_distance = m->delta[0];
>>               if (!lookback_distance)
>>                   goto err_bogus;'
>
> Maybe just kill `goto err_bogus;` too, like:
>                         if (!lookback_distance) {
>                                 erofs_err(sb, "bogus lookback distance 
> %u @ lcn %lu of nid %llu",
>                                           lookback_distance, m->lcn, 
> vi->nid);
>                                 DBG_BUGON(1);
>                                 return -EFSCORRUPTED;
>                         }
>
> Otherwise it looks good to me.
>
> Thanks,
> Gao Xiang

Sure, I will send an updated version later.

Thanks,

Hongzhen

