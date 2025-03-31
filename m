Return-Path: <linux-erofs+bounces-132-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E77A75DE2
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:44:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQwSn0jdpz2yFP;
	Mon, 31 Mar 2025 13:44:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743389065;
	cv=none; b=a+Z8gFX7rg3cYA487RpE4Ssh/N5KUlcnTf0B2GBMBFoRqQ6pMdGRsNhhkNqnGDhP2OGoMadlValPdzpR+KXqBRnq8coD89hwUUTtMYM+MtkY/ubbFGe67cHD8+dzresxtBkovU/Pu7IgTWKXYWCU9zRDze400S8wAAeLWP3CdvWb2cKpopyLW6nQJMga1kkIOiZPXWMOsRN505R9XuUH04ko7Z0eydEi5w2ytMd5EKhG5ZNGoZeHa3VpFH1jfxUrRCXfu6oGYfLKl3gyle7LfG/6QGtsixatEKquG0iNVnAEe8qG0MwzVr0KeVJ/z44e2eefblNW1swk6PSoeO5JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743389065; c=relaxed/relaxed;
	bh=RnoDTRNko+9S1JNn2nnbKX17T9hcYVNFQ8u9P9wIuhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duFpCtD8Wf6F8qVxOwRpeF0U64+M8eB3YdSZ9MO0dFDHWkmfReCj75cb0qCOTWf5NIn7cn3guGbFONNV/I4hMQXDcGb5Gq6pVCmnQ+3wL9U6aUtyOErsSsKbJcnQqQTux/Zc+/bKA0XVGyeSuZ2ZzW4bjLgjNc+wKpuuGKpmzqI56UcmiKpYMdkE7GDp3X9rOECiugtSjdNHVHhxVr4/5QPr4g6L8eiHvohaok2RmYunADo19OrFUrTHevJSiAz1wwbJPf8dn1YXTv8dPr6umvXOUrB8jv35LUZO7cOCD+6VfQCk2Y2+XBimZlcUuTsA5TbEWKzhwEU1ajgZaux6mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k/loXLl7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k/loXLl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQwSl1v5kz2xlQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:44:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743389058; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RnoDTRNko+9S1JNn2nnbKX17T9hcYVNFQ8u9P9wIuhc=;
	b=k/loXLl78G1MT53BbrLKdFv+JzUPpG0j1JNKDxZD9t8JLJHHFxeF+6Cp7WujsbBEj599Oa6sVyxuqnAZ+ueoAUfRiEpwYIH7FaNEvW86R/0hhs7wuM6ZHM2jsyGHeKj0/mM6e+kDGdAYjMDNwSCZeH3U44AmYF/u5DB+LCK1uZM=
Received: from 30.221.130.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WTOphfz_1743389056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 10:44:16 +0800
Message-ID: <27fcadc5-38c5-4850-8b02-73ecde092d43@linux.alibaba.com>
Date: Mon, 31 Mar 2025 10:44:16 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] erofs: set error to bio if file-backed IO fails
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, wangshuai12@xiaomi.com,
 Sheng Yong <shengyong1@xiaomi.com>
References: <20250331022938.4090283-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250331022938.4090283-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/31 10:29, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> If a file-backed IO fails before submitting the bio to the lower
> filesystem, an error is returned, but the bio->bi_status is not
> marked as an error. However, the error information should be passed
> to the end_io handler. Otherwise, the IO request will be treated as
> successful.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

