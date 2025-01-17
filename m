Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F16A14E98
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 12:40:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZHqC2VVFz3cj7
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 22:40:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737114038;
	cv=none; b=cPFwvmcUww2sp7zruqwu7vTd+U0O8pbY1//uPf/VGyFfw72GY+U0hajE+eOsCUVaeOboSRGDbPO4QcOVte2PSml772cJcSuJxxW5Wjyijsx6CH5NKfU3ALBXZSJl57EmcSIf7Nwmty6+ECyt82dyVv3f/dW4sg1dO/Z4Mt6phqDL4peVgX2VuI+eU8ghDGn6c3pwC1lUV9xZPNRtLZTViOsyqOX9u4hVgpo5fZslLl6BLozkAavEGQ7US9iy6hpRmlGRlfbMkY7xNH+9+otkQue0NpwmzJf39FkGVN6J16omEWh+QJLSPhTuCbMBC9v6CgT4h1stmx+yxALRktVzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737114038; c=relaxed/relaxed;
	bh=+ammakNym+YU7iEzIetTVk753hSn0YiReK9/HCDyrWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ9AGXmZUceDLB6t+n72C3oscz/08vDYt7dXES2ZYPprDwLsYxLLptY+aJ2WW/rO1kyiLiQxkFMVtFnFWqjVzuGChXCLGh7WuFohKn3v3JBHJlHW3UG9o8dXuSIIRDMVo7wB40PdYF5dqEc3JgXlhe2+tYWV8Rfe8pU5b+v5rYLHXIlgJ4wmlTW329mfu08rLQsmFF8dCyJJk8ser8sQxrhGacAWb2sqUXos884HKCCgcMoWXtnGA/td5qSmI182t+MAYwxsGmmkdfB4g8TX8PV3kSqkRwUAcw3Fv5U08bu6ivp+IM2aQMPNBK/QST23qaP0s3tc3vKiazaNQhgKIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cHS0Y85p; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cHS0Y85p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZHq903WJz2ynj
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 22:40:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737114031; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+ammakNym+YU7iEzIetTVk753hSn0YiReK9/HCDyrWg=;
	b=cHS0Y85pgw9ILy06Vxf1Y2YlpmRYb0is/X6zewM7UZzP4X7QOIEiPyEVWIdgZztzglZR5CcLUDwtKTPHDZwbuzyASL7DWx0kqdkYUV3drmpRbFwLr0Bt4NzifD+eP3n9SQN/TsarLOL+d7GFgQTmbD05WuNWJ3tqdRBa1ymnxwE=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNoqB9M_1737114022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 19:40:29 +0800
Message-ID: <f28ec0e6-9a17-45c5-9f15-4fe58f679a24@linux.alibaba.com>
Date: Fri, 17 Jan 2025 19:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: remove dead code in erofs_fc_parse_param
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <DB86A4E2BB2BB44E+20250117100635.335963-2-chenlinxuan@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <DB86A4E2BB2BB44E+20250117100635.335963-2-chenlinxuan@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/17 18:06, Chen Linxuan wrote:
> If an option is unknown to erofs, which means that option is not in
> `erofs_fs_parameters`, `fs_parse` will return -ENOPARAM, which makes
> `erofs_fc_parse_param` returns earlier.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
