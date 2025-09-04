Return-Path: <linux-erofs+bounces-969-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9937B43396
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 09:19:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHW8440Lrz2xnM;
	Thu,  4 Sep 2025 17:19:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756970388;
	cv=none; b=YfQCY+e8CDcGER9tUilIWoYMIgx8eDZifNZj2RTJx2NsJPq0aPdvxa7EiPnnpIHOvj1SATLJXzi1hBFlKvdJ8tXbvojPkfuhBEtN99Ml6xLsnUE6COa+zoJOHgvGAkG4vWFhka9oB/hshTglHX10+qMN5p+jM2EzVH1roEii4ymgAZEPKKAwL7hWXQtTBCi9pkYes1HNEnKyR/BTUmjMnosmOFd3SA9/F6dGPzngkZAgPiSnLU4+19lXek03hUeXHgvwJYoxt4dQaPFazcXoS+5r12noXqKJt4lBa4877Ugu9A//lvZbB8xIb/fYkpw4vFfnFhfxJp4E/ljPzRQqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756970388; c=relaxed/relaxed;
	bh=NFfZopMs2myqMx8UEaE5DgMmXf9eT0J4iTqK5c+TBL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRMRDIajQaMjak57s8z+Rj5CXYsz4DyNTusjj9S8VuHlsv862dDQAy7OKlBFiyQm303JVzeFBeMVUDnuB+B0kZPxmt2IiDMGPl3BDsAdh3xMPseA9caa2csfrVRu+w8+/xmKz+418oIvmGEAWpsnB+GzfsxpxKVTGNKPeMfFY2zvtWf8VJE426xPINqftyKXAMCAUtz65k4dulEWVNoOi7Wz+ZuiXEhEdHRAUrCiq5Uvi6/UyVDWzDcP5s2mn0tgZ3/e0UYWe0C+lmSA0zubkUPwkmD7WERzcF8V9eahVyw6NxytF4RLXO9aVsuK4b6IKlLxPIsZQTKpLIPaKpBKLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8hRXOl4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8hRXOl4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHW822SZpz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 17:19:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756970381; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NFfZopMs2myqMx8UEaE5DgMmXf9eT0J4iTqK5c+TBL0=;
	b=W8hRXOl46dKLbfyqYLyYI4Sc1QJ6rwcK0JaUVtVGB/yE4m6Bp1ZvvYqA4NZmZCT05br1MdcVLuDQBGlMzcQbtdszp9yKtCcRUpM3qdatpfa4ygnkoJM1l9YxV5k6l4I6xyTSHeuYDRWo03R0tmGcADxNPJDF0IwyAMj7za3uwTk=
Received: from 30.221.132.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnEmwFl_1756970379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 15:19:39 +0800
Message-ID: <641b4b4d-d1b9-421e-906e-20d3c4c53d8a@linux.alibaba.com>
Date: Thu, 4 Sep 2025 15:19:37 +0800
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
Subject: Re: [PATCH v5 0/3] erofs-utils: refactor OCI and add NBD-backed OCI
 image mounting
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250904063603.560-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250904063603.560-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/4 14:36, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This series refactors the OCI handling in erofs-utils and adds NBD-backed
> mounting of OCI images. It enables mounting EROFS container images directly
> from registries without pre-downloading.
> 
> Chengyu Zhu (3):
>    erofs-utils:mkfs: move parse_oci_ref to lib
>    erofs-utils: refactor OCI code for better modularity

I've applied the first two patches to -experimental.

Thanks,
Gao Xiang

