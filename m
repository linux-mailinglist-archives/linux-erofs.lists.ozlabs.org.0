Return-Path: <linux-erofs+bounces-877-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26CB31359
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:37:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Zpg5fVpz3cZ2;
	Fri, 22 Aug 2025 19:37:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755855435;
	cv=none; b=PjXwZOHMJOad+raMpf99E+eMma9Iyrf3lCoOTk0XmaBjhGFhSOBuufn3SBieMWypu+3d1QP9iSUm/5jzjYAaDdPqL5qDuwBdIttnvAetxduKteGcg1aULciE3tB1PcMFtbbit56D9abIsw9ZvDOqECpdyW/AO3aDBIprn/vsMYoVuZIBINf4aDn5oqfjwXB3RRGUoNCKr0YQLaCi2Rds5t2FLb10ozNug0WQki8k8NDzOTaw3o6BDApgHKNfv9LdnoS6coHG+WlxI9bkVQxuy8MvQfwOeWNDxaK5ZQ7IC5DSkVtSwtTpZWqXDRPlS/KuTalcOLzGYe37rBhyIaMrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755855435; c=relaxed/relaxed;
	bh=s6hfc/wgFBJIokJ9DE3v6q4TypQUDIj8n2VPN27L7G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQBaIT0z+jI3+xV0kd404YFJwPIXhltGxy/350KTZ46uqGUD+zuq6XsKvap8F+WfM340lVOKkm2zgJWUTRu92U8mRwN2n6uTVISBX4T9oNyhZ+GulY9zM8Ap3ptb5R8nz6G3fWU1IpcX1Ve82kEr9XFWKlT1llqRL3wjamtWhNjuDL6KVgevfUvzkK+DwuTj1QKgZkWYdFTGu4UmwienePX8QumFxPxA61ob5Xiwh2Ku8arQ52JP5T4q44Ah9eTt96Hlcauzucgrjh2ESZfzxnukZdUzAbi3sEfNT74fmXX+RK64c34VN5y4Ylhsa9RQtZeo87vBn4sIIIrUe/gvTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PD5WLCj3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PD5WLCj3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Zpd6rS8z3cYJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:37:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755855429; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s6hfc/wgFBJIokJ9DE3v6q4TypQUDIj8n2VPN27L7G4=;
	b=PD5WLCj3uPmH/iyx9BOlTYnrW/dGHZXv9tCxUM7F7Pkh84fcYxMQ76l1PUWAEeJthrCZ5ETVuKil3Wq5yqJwZ1Epo/BJmBA/12w4GPoPn1ob8+sIVf+8oMpgqDD0bG2mKOOalKk+XH8yti2u+iFFQCzYO2XAamS9cXhxv1+E2fs=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmJFzdS_1755855428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 17:37:08 +0800
Message-ID: <7b82b184-65fd-4135-b9dc-e54c4b3adf95@linux.alibaba.com>
Date: Fri, 22 Aug 2025 17:37:07 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
 <TY0PR04MB61912BD4A4596D2CFD485B5EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB61912BD4A4596D2CFD485B5EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/22 17:35, Friendy.Su@sony.com wrote:
> show both 'before' and 'after' is just for debug, not so important. OK, I will delete 1st one.

`Aligned on 0x%llx` is too short and ambiguous.

Even if it's a debugging message, let's fill it with a
more complete one.

Thanks,
Gao Xiang

