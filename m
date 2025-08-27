Return-Path: <linux-erofs+bounces-919-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE0B37A58
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 08:29:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBZQ46Xb8z2xQ0;
	Wed, 27 Aug 2025 16:29:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756276188;
	cv=none; b=iowKqIUvYnNgzzqYY2uy7jHaDKCOEpiYnoEDAIHy9TKjuRseVUOJXHVOxd+Fijf3KnL/Bkkp9i44Quavz9S8/r7a+YzdXTRmkO0RljaaVKLtCVoyfeAs01vu738yrFMrCYlbFFf6255El5auXKrIPC6WjHYJybghr9JtwKdYyM75dZb8ADohUZoM/dMvm2YhqB4XEy1St3RNg7S9g3lCzqhIYxMhzdau0EO//jamANimg+NwL323zQTr6oZAeeYq6Zn3uX7B7HFdzqBnhKECPR3UprD7iOAlJP3fjxeJYYRp6Cioz6XfJ2CY8bMlha6NDRA2gOK9XWBLUYn1uLllUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756276188; c=relaxed/relaxed;
	bh=nS5LP+r4/9hJYgRE81S0dB+UmtSkvP5uPow+JVDkX8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEOaqqBo1yf9l2wHGiJByc4SoP4A1AWDm1KAyRZ0BMzMJjaY4a4G7TjeyyLVO95bmFyvCg9eJYavTpY7Pbw3J8kBOqoMi7BXiO6XinGs655ot0N+oq+AESYPpY3neJgrhHFGn9Rn0Laiq3JRgCTijy4cClkPQH1fzX1yTFN/HcNUqNALcS807AoNolo+HKI4SU+1NYC0V6rC25/plh5ZKMLpsPVq//VukWaIj7V2QIP1pA3D5qYVYzozCkuAYqn4wWl9J90YcIiPxmQvq87A2++73A94iENqiX5jIIQogwtqq8xufqWpqVrurpD7Flxmy03MZSmKuMNemauUKt3CVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SsRk/HYb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SsRk/HYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBZQ30SZVz2xPx
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 16:29:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756276182; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nS5LP+r4/9hJYgRE81S0dB+UmtSkvP5uPow+JVDkX8o=;
	b=SsRk/HYbmTzi/7EEEbgKRyO1+ASUM3P8La5T62lJEAfdeLq+atFdPzCz3diTxHqy/4eE9S5jmh/3yf6fLkLt7AKf/7nZirTNFY39xemOkbmwdwWgKu1ZJq9WiFV6wnQ5RKYp8hVwhgVOYxrtYVg4+GL4gsWml6GEdXEQAzJGKe4=
Received: from 30.221.131.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmhwxtd_1756276180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 14:29:40 +0800
Message-ID: <57ed4010-b6b0-48cc-b442-d682f798f6f1@linux.alibaba.com>
Date: Wed, 27 Aug 2025 14:29:39 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: rename `fallthrough` to
 `__erofs_fallthrough`
To: Noboru Asai <asai@sijam.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20250827062235.213715-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250827062235.213715-1-asai@sijam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/27 14:22, Noboru Asai wrote:
> In order to fix compile errors with libxxhash,
> since `fallthrough` is used in xxhash.h.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

Thanks, applied.

Although I also think libxxhash shouldn't export
such common name as a basic hash library, at least
it shouldn't confuse terminal applications using
these symbols.

Thanks,
Gao Xiang

