Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0007A2E270
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 04:00:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yrq7H1YXxz305P
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 13:59:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739156394;
	cv=none; b=JxSn75liHj4Zv4iDas+Ox3JL3QuMU40AL1pFFoo8H9nU5x1E7PLhH51b9ZbOUuPiBdaPdqDXU/nExf77I9+peema/fRWX5l0XwA7eWZGHnvq+eyfo/sIcObXG2CxzS7hbAcdeZ67QyaY0eow3XhQRB66jZEWvkhwsXKQemu0TbY/rpxgWXqe4LFAspicY2jJt2vn723zlAkC3ZiQ0AverlpFZWv3DNpzwJv/Fr3f69mR0uL/bzACvpGzlkMxyHJau0wG5QZWB9bEvZylU9yv09UXqr/2TVf9Nh9w8Sbc0+qeuhR4NmDUO5qledPi2OMi3UKBCp9OqnhQZ/YEr3ibmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739156394; c=relaxed/relaxed;
	bh=oBnfMYylPc9oTiD86UN82wcoKRob6MYiNVBrP5/R5zo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcpWjNjYudIo2jzbbL1aHu5I0KEwocqOG5qhlzzZ6bPOXmIlLoXGCEvwM7QKXuQmJoBgsnkO06KYKv1SLVaCm22v/4XoYHTeGyM0llSIolchNGhNCiCzuBRoQgpLLUaWJDsvuhoMVj7nzIV/XxWYUDWDCJqIro1ZaReJRUVoYKOimhw7V2voBR6Xqxdjfj8FGoU9so6IbvppBRrl/K5DJK3XEA8ujZBq2oI0oQH470C/SVJSP0mCPkcmK1DFROFv1i+C6PnNrtSVmWsvk87yAhnS9Fg5kBjv09z4cpuF5ABPqZwlMM1qwhAYZ+Ky0wl+Rf1xMmxiw4LW5fTs6DITvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EYwm4CG1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EYwm4CG1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yrq7D0gVzz2yDD
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 13:59:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739156386; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=oBnfMYylPc9oTiD86UN82wcoKRob6MYiNVBrP5/R5zo=;
	b=EYwm4CG1rjtBdnKQhJSNjaFCNrCGdhD+yAqqiHQocD6rt9xJiuLSXODQmORM0KU+WQrumGbK6nqVRA7RXgufNEinAAd3ZTtif7nMEmHoFKmhIShSLNjjLMflU1WVIAUlJ1AaME2tJNEe1WQRMKIVYQwt0Tfx2p5YMoSnPZ0LcQs=
Received: from 30.41.15.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WP4ia0y_1739156379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Feb 2025 10:59:44 +0800
Message-ID: <5c55806f-56b2-4e00-8b88-ac97e5733b57@linux.alibaba.com>
Date: Mon, 10 Feb 2025 10:59:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250207085056.2502010-1-hongzhen@linux.alibaba.com>
 <29c5e464-4a11-42f4-b303-279c4b642471@linux.alibaba.com>
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
>> There's no need to enumerate each type.  No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---> v3: Code cleanup, remove logically inequivalent changes.
>> v2: https://lore.kernel.org/all/20250207080829.2405528-1-hongzhen@linux.alibaba.com/
>> v1: https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/zmap.c | 60 +++++++++++++++++++------------------------------
>>   1 file changed, 23 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..7dba1573498b 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,23 +265,20 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>> -        switch (m->type) {
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
>                          if (!lookback_distance) {
>                                  erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
>                                            lookback_distance, m->lcn, vi->nid);
>                                  DBG_BUGON(1);
>                                  return -EFSCORRUPTED;
>                          }
> 
> Otherwise it looks good to me.

Sorry, I was wrong.  I was missing the part of the end of
function, how about the following diff?

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7dba1573498b..d278ebd60281 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -273,7 +273,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
                 } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
                         lookback_distance = m->delta[0];
                         if (!lookback_distance)
-                               goto err_bogus;
+                               break;
                         continue;
                 } else {
                         m->headtype = m->type;
@@ -281,7 +281,6 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
                         return 0;
                 }
         }
-err_bogus:
         erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
                   lookback_distance, m->lcn, vi->nid);
         DBG_BUGON(1);

Thanks,
Gao Xiang
