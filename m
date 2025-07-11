Return-Path: <linux-erofs+bounces-591-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73424B021FF
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 18:40:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdyBY2SHJz30Ql;
	Sat, 12 Jul 2025 02:40:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752252037;
	cv=none; b=OXqjpOFvd6szZcT+oUHl+hV+Lsz91lKkcVzYVEi/JY43bAf1YTWFBSWDGDs14IdHJmCNg7tJjH3WsGadxITJJx/EQybJW+2TiAUWCguP5mGoPJCzHCXfQifEttjlDj6/zESj3VoCWothiRY5xYglA4XWxx5u/T1Txqj3HQce4VktVJ9S4S0IYka9AMk86f9gg0qQyrhSlb3c3LgOQ2ZIbvKqnaz5LyzQNM32W9BcLhlc/WRYQENEdIyaiLGphYz2c2dvUSRvOAji9tUz932XLmX0P4tL9sCCA/ucb1Z7yqMxn/XF6G9fQDSFWNrLveAoFq3CirEMOnvzJa0vYO6hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752252037; c=relaxed/relaxed;
	bh=EE9EGF34XfPKkdHOgO34S8A16Yb/GYJyUhSDwAaXkz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Edl6k9FqWHDu/4NCL4bJf5CH/fzBu03pdrJHUK+ikIkUOSWXxAzZWnnFMoZ+9RGSxl4AGHeRTLsbbRfWcpcTbYmOKLEyrljuFcWH81JHsZydDR8rOulXPHBi0/MDfxMTEqUYJRW2D68XFJdWE7Q59WZ0mC/KCRqi6xNwYI8GYWDO3Nm9JoYz3xOGE1WcaMZ53ihtLbqa7mnpTgsrGgtrljT6Z33nwlQn03oyAo5tUE2vJOChRV3RgbHGYxCAoZxbqM4uxb5hsmn/wDAbdLJWAEzSnqLdAHLv5L3mW9OTT8TjJnJHE9XFa1OMThKt2IMD6U6BHnu2rIzbv4wIOc8IHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QeRk2WKH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QeRk2WKH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdyBX3jkqz2xsW
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 02:40:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752252032; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EE9EGF34XfPKkdHOgO34S8A16Yb/GYJyUhSDwAaXkz0=;
	b=QeRk2WKHAcbwwYyZN+K7wqZO7m5ETZdxVx797x4lwWYoiAksGsnudglviZXgsoLkx9c5+7V+2EinX9TLMxB14E9DeAVuuhth6FbZ+IfwtXhLcrTDYeRYrtwNHD/JvD46BV+w2ZruKSBxGzDVD/MLa/pka+iTrfI5CLPim/4DlbE=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WihYYIf_1752252026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 00:40:27 +0800
Message-ID: <c661062f-09dc-423c-a859-9581507ba482@linux.alibaba.com>
Date: Sat, 12 Jul 2025 00:40:26 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: lib: fix uninitialized variable access
 in bmgr
To: Yifan Zhao <stopire@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20250711161615.44832-1-stopire@gmail.com>
 <20250711161615.44832-2-stopire@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250711161615.44832-2-stopire@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/12 00:16, Yifan Zhao wrote:
> Missing `bmgr->metablkcnt` initialization leads to an uninitialized
> variable access, fix it.
> 
> Signed-off-by: Yifan Zhao <stopire@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

