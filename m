Return-Path: <linux-erofs+bounces-1305-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2520C1ED6B
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Oct 2025 08:47:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxx5c1D2Pz2yvv;
	Thu, 30 Oct 2025 18:47:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761810420;
	cv=none; b=JXaF2xyjhkh4GmeS7X/9OAbk9CvvojmKfrQ2PvwVomgVfkxahDNhiG1jEOZ9KrchTQCLQUWbaVmgjIh+BYwDcVh33PSkdXoN7+RYB/o4Z67zR4QbxTAWcjRdKzmq1KjKg8jX9WyCFaFAyi5LZRZ5IF8iTXE0FqySssnfbGjn6lOoSDYxLSj9cy3q4dN9SU70hBGcCTc5n24H3656N44bb0f7sC8xgDNjtjMuxWXPWRfrdaydVlMROlvXht1Z9Bj6a7GdM77SuOD989NPsOy70ktpyvjQ1Dxko9WFzAdtzbvgbmx04fCWVldwigPq6/OvAKs8eKSRukKOOpHXmmewVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761810420; c=relaxed/relaxed;
	bh=xMEyKm4d/bVC+FeUPGmSVMI9W15P9kUFa+WYSNGougM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zf4lCYeUDntyy39RK9QnQwdTUc2LO9LrM2uUMHEV4P4k0yCFfmse0zGED/zmwTKOJjneonLHPMERwEL1ny6vDpvUHdHPKtC74G+cZL+GKtDuPnW9n+o9ohyT0EXAFGAtRD9pSfejlXcBxckGgsQCkg5FdBnfX+EEVN9ZjwHC1QHDXnpjlcGL6+mSmPOupu5iK+FlLyWEEmlptVcTuRtcsNMRg0p3WBJxl/9a1Wen/xfdrZfNAGhv9yxfrdD4T58u8f8tFmjkcjKAEML24QkpDLhIqPAlCH3zYoS9RpsVZnGqSJvnKKaclqyJ01KNTl2xyjgtdKBFyKz+tL9yaKMcVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AfK9vna3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AfK9vna3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxx5Z3JQsz2yD5
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Oct 2025 18:46:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761810412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xMEyKm4d/bVC+FeUPGmSVMI9W15P9kUFa+WYSNGougM=;
	b=AfK9vna3dBsJLWSPXLjSgrljKhPcA9n7aONc3mv1M/AqII8+7dFf85zTQBJMDR1Tlv61kR8y4l9dd6n/8U4NjkayV//eOTdscTMXqXB2uUBj2aohw+8uhFi+MW28s78V4FACL073Av3srsOG9XO+O0zrCpBhTKqHCrt6ZKy5ghk=
Received: from 30.221.131.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrJA-v-_1761810410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 15:46:51 +0800
Message-ID: <d6b949db-8900-461f-a126-370a12da517f@linux.alibaba.com>
Date: Thu, 30 Oct 2025 15:46:50 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] erofs-utils: mkfs: Turn off deduplication under
 chunk mode with '-E^dedupe'
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20251028032809.1371395-1-friendy.su@sony.com>
 <20251030041525.2094223-1-hsiangkao@linux.alibaba.com>
 <TY0PR04MB61910809A139F90D72A84DEEFDFBA@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB61910809A139F90D72A84DEEFDFBA@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/30 14:49, Friendy.Su@sony.com wrote:
> Hi, Gao,
> 
> Patch v3 works.
> 
> not chunk mode:
> 
> -Ededupe -> deduplicate
> -E^dedupe -> no deduplicate
> not specified -> no deduplicate
> 
> chunk mode:
> 
> -Ededupe -> deduplicate
> -E^dedupe -> no deduplicate
> no specified -> deduplicate

Thanks for your confirmation!

Thanks,
Gao Xiang

