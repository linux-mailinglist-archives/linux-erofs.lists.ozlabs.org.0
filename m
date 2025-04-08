Return-Path: <linux-erofs+bounces-156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF146A7F309
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 05:07:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWrbY46zXz2xfX;
	Tue,  8 Apr 2025 13:07:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744081641;
	cv=none; b=WIs8apVS/Efkb8ynWovpPlAjW7FRNzmoyTy/pypBs1W56VQpP/RR403LoV4E0culSwxCVfpCCvMtGYdpnOwZ42hFXl341MqPd1nSComB+0Uq/svH9alw3rZQ/7Su9LIWGziXqiNNaIgQCAQTOXNd2uEgXrzo+9qBvWUBiMrGBw+gnMQrXnYSDmJ+qk5m8YVFX1pmpICB+wk9ihuZXE5hWRAqyaQkA72F7LwcwCdhnk8FFb3DCAtJuey3pf0tg+ftavgHs2exJ+L4WPSE3XWOqAPw2BZYvRA//BJKmOifh/f0gv5H3Q77cp1VEsxOZ7hOKn2DbgzCxc6CmXVVx0aTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744081641; c=relaxed/relaxed;
	bh=7/qcQmc8TlRDaeREPlCChF/VdJV1qOYf2bxSgnptYUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZWWzZ1yosuKeUB/atJxDFnOljeXIespZ7AHlE9Imm5iuROhIVcrKGhV5hAVN4oFbwnMur1aNaTytmHtEyXu8eNusyljuR137iR3PSeRz3DUZMnmbDYSR6lTGYppbHdG1iYkBdKQjMOLg6U4v0JpBi28yR5EK8lRvhV4ggzAPHXhfwiCMuGFM7bavLmBuGh4O6G97Px7O07d+wKKRnq7V4SfupeTokymag/bLS8hyDPoBrKyeuLPI2YqhYc3IoCnQpS7QJRL8TxC3RFD+aWKwOQm4kTJz8NJYUy46GZHwF4koqsnuM9XkFgkVsUXCbPVItu7TBZYMdQLUjydeah18g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vnifDesF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vnifDesF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWrbW3JvWz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 13:07:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744081634; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7/qcQmc8TlRDaeREPlCChF/VdJV1qOYf2bxSgnptYUE=;
	b=vnifDesF5MW9YfaFRK5we6GdLVX9h6062B4I8eZ5JuvQz/X3sy0+he8iLubpLPSWYwI/CD4Tx3cWyQDxHaVMouEtSM2kHBOjKFqxPiF461tuTsz6r9EHgpAl7S+jUrIqXth05x04eyW42I6BPm/fLXQvuWRhYnIlGLhmBGNwCAA=
Received: from 30.74.129.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWB03J1_1744081632 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 11:07:12 +0800
Message-ID: <da085862-1c82-4b3e-82ea-b54e2432d96d@linux.alibaba.com>
Date: Tue, 8 Apr 2025 11:07:11 +0800
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
Subject: Re: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250402202728.2157627-1-dhavale@google.com>
 <CAB=BE-TzPKSsHo_nvMuGkB_4JbbP8OZ81ce=76y-28nAeZiniQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-TzPKSsHo_nvMuGkB_4JbbP8OZ81ce=76y-28nAeZiniQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sandeep,

On 2025/4/8 10:53, Sandeep Dhavale wrote:
> Hi,
> Gentle ping for review in case this slipped through the list.

I'm working on internal stuffs (unrelated to erofs,
currently I have to handle erofs stuffs totally in my
spare time), also does it really need to be resolved now?

It's not like a bugfix, if it's not urgent it will be
landed upstream in the next merge window.

Thanks,
Gao Xiang
> 
> Thanks,
> Sandeep.


