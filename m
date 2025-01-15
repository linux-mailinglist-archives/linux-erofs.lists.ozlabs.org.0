Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1DA11E8C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:49:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1S50Mkqz3bd2
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:49:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934579;
	cv=none; b=g2EM+PegaF1HFNA2uM54+G98HwKfe1hEU639Q+1E1NS4fWe95T3uwVdkKjCGizInbetjRauAMpRmUeG7e4//dBubLzYtBlivN1TQDlOS37c4jHcnEJD9r82YRm7AtTN+xiCQWa7GvUT8I/xFWt2nvLKb60ZF2jq2dGoaAHP9aOc/QsNngAQ8RDXNfWXffHYcX5JlI0/0Dn9JFDfsUf87T+40wuKDXK9to2lHN0sSXLEj4Y/KBvFilWuJzGIkbmv3vOo2k26kGI/ucrkH801BYCgAkMi9w5mXRv2t6quwaRgjGBahqwVdRFEFQEbGVMp0znAaSonRWR/9Ec+LFmkN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934579; c=relaxed/relaxed;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGUCYMA5PthozoYmQFXySSHQtT4JMLWZeZJMXPWSIjD0PKcCYHgm0lk88ytV3BGPVmnrQttS6y6eHD680SJ38HRzr3MgxcZdsDJabKR16RfWSYz/jRYMDaR1FJOkjSnEoGtFBwy1VrzRY70AlgC6tY2J/jRaG4R1qDRy+VIktGIScxeJnKbre3TdyLAF9f/74ni0XX/jFwt8ExGN2pxvOL1ODeB/h05jlNPdpzo8rrLe3SBfdMPw5AB8oy09ONszaoHS7dHM5UcptBsuDCNS+DC++wHyovFB/QsEEx6vZs27HPIVfSGLMPdn+C5RVR+eE1TppP9C7IGDNne7RD/D7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r6g704jJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r6g704jJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1S12FGpz301N
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:49:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934571; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	b=r6g704jJwKx4NPoW+r/oSpCQ5TC3jtc/MuVhanlF0isGvCb2c8fAcUNXgCpdlvQ7py29xwD3vHS+H/UvVMsz3AgIHOaxO/fQTFmRsr68Og7RJJhicjiMIG89Dp8jsyRwRJaTfDxQUI452zE+LJeyf5bpjrW8+ZrXQZPdvj0No3M=
Received: from 30.221.130.98(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi52po_1736934569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:49:30 +0800
Message-ID: <cfdaa8ac-07f6-4474-94fd-a22426a7047c@linux.alibaba.com>
Date: Wed, 15 Jan 2025 17:49:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] erofs: use lockref_init for pcl->lockref
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-8-hch@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250115094702.504610-8-hch@lst.de>
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
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/15 17:46, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
