Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19ACA2BEEB
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 10:14:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq7Zw1LnXz30VM
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 20:14:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738919670;
	cv=none; b=Gk8+j4NhkXN2Kkt0h9YizBTapMg/Avvfxx3ZUmMfTJDg8hznc/RzofxksWaNkdEXf5CELUimF1U+KuHt3jY686mQBUrH++wByTYb3J3wotv3+Uypu1tRNqK2MQKGbdbl6IySN68+6ppqb5wtveHGyVrDeR0iK0tYuE92ffc9rpZrdtraKdRsYeYwYTpq7fn7OU2a+hZqoiTY4sdQAOYc4Q7uTT3AkKiU/uVQV1ClxTqXbTC2BBJ2+Ho2C6cMsBpQHEeqMjyoV5dKcn/B0OxZXHNLtdWuAaHu4RSq8fgspUH3pe5OCsMmQeaxOznwuwsnc/Q2f3tGQ/cFUUiOIuWNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738919670; c=relaxed/relaxed;
	bh=DCJRQQSMDhi4PPr4vjXgNPiPlE/jCmmPdCQjjVLbenU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSJZ+UMWiQck4QmjaS8r8QM3eegMEWK5174gxOLKU0upGaQcK9lwJuSlIMxre/fuVg/+RhxRdQSTiQ1ogvbdiNTq2ouBU25MsExhhcJP9emMgXRhAdt/weCaxADqhZvClOYA1nArimPUIRMOg8ym4pwULjAFWHqg7x+zgGIxeofXYf+zoGNCq2TZylWZR17CiF034DNoIlaVe+7Prj228LtU4joI/YpMsLvpj/RkPSbPlRCaxl9bXe6gXgGSbM9/AoSH5UhR7RVXTWQTk+3B3T59jDonWx0e7NsbIUTzq/df/cV6SW9AiUj/ZLNehorVM+v2YmRTPW50jtGDskMapA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l+gyVjHX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l+gyVjHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq7Zs2yhmz30Ss
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 20:14:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738919665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DCJRQQSMDhi4PPr4vjXgNPiPlE/jCmmPdCQjjVLbenU=;
	b=l+gyVjHXiCz61H7zuiR2QM1fkODxgrH2dFAMCXiYAQRe/pA090HbHKUcOym9hRT9GAz5l0NY97JrbzUK+OOAhPoKdc33K82IBsFtMyii9hctGDTuwGID7dkXi84XC1Q3wmW/YLydq7UHeBlGzDbHQaK1bLM0c2LSnJ++RH9Rk8A=
Received: from 30.74.129.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOyysU1_1738919663 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:14:23 +0800
Message-ID: <29c5e464-4a11-42f4-b303-279c4b642471@linux.alibaba.com>
Date: Fri, 7 Feb 2025 17:14:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250207085056.2502010-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250207085056.2502010-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2025/2/7 16:50, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---> v3: Code cleanup, remove logically inequivalent changes.
> v2: https://lore.kernel.org/all/20250207080829.2405528-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/zmap.c | 60 +++++++++++++++++++------------------------------
>   1 file changed, 23 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 689437e99a5a..7dba1573498b 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -265,23 +265,20 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		switch (m->type) {
> -		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> +		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EOPNOTSUPP;
> +		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
>   				goto err_bogus;'

Maybe just kill `goto err_bogus;` too, like:
                         if (!lookback_distance) {
                                 erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
                                           lookback_distance, m->lcn, vi->nid);
                                 DBG_BUGON(1);
                                 return -EFSCORRUPTED;
                         }

Otherwise it looks good to me.

Thanks,
Gao Xiang
