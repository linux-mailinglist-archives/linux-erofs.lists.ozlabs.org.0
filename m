Return-Path: <linux-erofs+bounces-1500-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DBCC188A
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 09:25:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVqkl2BPrz2xqj;
	Tue, 16 Dec 2025 19:25:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765873551;
	cv=none; b=EwMmfSNusRX93K5TZaHGG0ihvEVRGQ+y8B76C6+p22ocsxO/ejB/V+GL5XfD3LuVVQzOsDIYNQrjgYS4lc/gZZCyW9i0L/M9lCd5bfop7DYPhSVursAOvqdmmzycZ6kx+sojQW+GYjD8LxM4LbXCJbBqPIfNEZGUhIksxXYXfDUBYbrlxYSRASeXCtdarQGnYWM64+oCpdTnbtzRBWG2L+Rx2QJjQyPAkAgtWFboqsFRCkF4oDe19kkjxAvexdqPZwa9p1Tp6F5Gh3ekk8gsC0l/VrYyC/E/5+yb7h9778BsOV4crv5QSSlh3t8gaPWuwd9N5oCHngh9Ybb9wSX17w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765873551; c=relaxed/relaxed;
	bh=9nYk5mXuNcuSwtL9JEiVNlZJ1bTeJxuxZrxzZLeGZxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr8o9lJMRSrNwiHeiPLwcjuaEzwHDHpacwJrhS4ziH9NJaLjJxFKa2Dxjovyx/VN6DE500gaaSFmJSIJ6TnoJqqNt23sIxCycC/GUTntRVZu1gl8c+gIZ+M8MxzuyrwhY50A525LbSpHdd+8OgV3XFNz4/vC+XsNfF5vC5M1ONF7WZ7C3m1L/uZE1qSmmf0UQB9zV2rtmCkh3JuRzFOa05MNZHdbjn4CDqb6iEZkkk2wugb0/wxLgbv6d7QebZucql/IXsI2gQnNy3R8oSwh1vowLmwBTPd4s0qTosaqYQ67Cxu+qzQhyvTbgHgI18P5HmNtOKqllelPpksMVOGscA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wLDQWFOt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wLDQWFOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVqkj4B2Fz2xqf
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 19:25:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765873544; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9nYk5mXuNcuSwtL9JEiVNlZJ1bTeJxuxZrxzZLeGZxs=;
	b=wLDQWFOt1stKWebuFwPipvvygNt08AvTeM9cZsPlJfOsgq3jarDduU60U+7fqs0mbVjtoyQ0W0tqIuv2mCn1leLTXnlqtBe6ghZklqNpvC79IynvRT/8ffy4syx+Q4gJ0b06HMWDhpiy4Z7pL/mo4Xeke470wKH2Q16QkfEtSfM=
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WuyVcWH_1765873541 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Dec 2025 16:25:42 +0800
Message-ID: <c599e70c-9c6f-4a98-a826-9fb56af5fa50@linux.alibaba.com>
Date: Tue, 16 Dec 2025 16:25:41 +0800
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
Subject: Re: [PATCH] erofs: make z_erofs_crypto[] static
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251216082141.108624-1-mengferry@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251216082141.108624-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/16 17:21, Ferry Meng wrote:
> Reduce the scope of 'z_erofs_crypto[]' that is not used outside of
> 'decompressor_crypto.c'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512102025.4mWeBSsf-lkp@intel.com/
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

