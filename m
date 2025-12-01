Return-Path: <linux-erofs+bounces-1461-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F0C959B5
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 03:43:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKSrB632Lz2ypW;
	Mon, 01 Dec 2025 13:43:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764556986;
	cv=none; b=El9JB54kYQ0e6dV9pdbrqBWb0o30O+YUdkDKPJgcqwxtrJnEjvxawQM5bYyk1ASnlVQ+1jHKNzAHrsUCP7xQ7M7Fg8z11OiX0nmgguRYvHCPFO49TrRlsup2Pz+xWVtjvSx+bEKZ+IuZaRjHrYbAk9jJrYDlGA02bGfi8o/8ElB4Rw4ula0rAtPiDkQ7qGQwcGHcNmSpW/X3vrBsNhv1LL+qLILMmmYHhmdV1lD5S8C0tDzD+APki+uMMXgCoF5+vXuFJOUvH19dNkImBhRZDFUUCeCL9arsKfnNNviWCdiamKpkzdOsnvYmHHKs4OvnYhfje2+2bk480/dtQHtigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764556986; c=relaxed/relaxed;
	bh=6gF1E2UmjIOc1205fgM7uVYLoYA2b3QtZ6YKzqBCTxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVpn6wZ5Tlyo2SsM68FSXIU8MaXHSJJ87bkznNdtIHBL1pyuHdV2ykYjrGAm5jhSET3kmg/k3q/F+QCCyHpo6lecMx9y0veGy1j3DzZURULyW013ZSTEOQ2W16b9c+t5w7vViNgrUlDXOMYn1H8Oq0768hIk4E87w1Hj3QyqCWB/TABX25ZwJIQoA7lf8993k0VNcxKaJPiyNXAODUXRGve9dRQZPo8/vd96g80FN9vvcEpVoo6R+Z5aRI5xsjvhyVK3oV0rt10I6giByRAjURlv922tuDe3iD080re5Pe3B3PhhCsjUDpIrTzQ71L1lHr/aajhOJenZQkIAnm+OBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IrPsOVo/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IrPsOVo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKSr96Zpmz2yG3
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 13:43:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764556981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6gF1E2UmjIOc1205fgM7uVYLoYA2b3QtZ6YKzqBCTxo=;
	b=IrPsOVo/lRuNCaqf8u0B/lvWUFKDa57ajlH9TMr9WdKMktCYLmger2JIj6LWBbFzb+I2GFrexqZ4d/5+eZfzEFylN+5FIm1bWQQPG8BujbBfazbimi9PG/2M434H7UlmJhrnvDoFdRupAlwG/UGNWnKcPEoh15ZWt1plL+JskVQ=
Received: from 30.221.131.75(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wtl.kQl_1764556980 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 10:43:00 +0800
Message-ID: <105b76e5-3c71-4039-9923-ac73fa541500@linux.alibaba.com>
Date: Mon, 1 Dec 2025 10:43:00 +0800
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
Subject: Re: [PATCH v1] erofs-utils: add myself to AUTHORS
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20251201023959.6767-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251201023959.6767-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/1 10:39, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Since this year, I have been working on erofs-utils mainly on OCI support,
> including OCI registry and tarindex+zinfo support, NBD-backed OCI mounting
> and recovery, as well as on-demand blob cache and direct-to-fd download.
> 
> I’d like to continue contributing to erofs-utils in general, including
> new features, bug fixes and reviews.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

