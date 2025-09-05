Return-Path: <linux-erofs+bounces-979-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76123B44DFC
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Sep 2025 08:34:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ65503zXz30Wh;
	Fri,  5 Sep 2025 16:34:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.59
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757054056;
	cv=none; b=MMVSpohhPoI8kyNPJGcV0h/+c3zNzgfAksHMAziGR/1bhtW1bmtwLFio5yKuKDJ99uTFyZhN/TBH0t0wxqQOuhN7e4rXLxeyOPM+mgFOvoLYh7A2Jyd28qZT1NL0KXQWbgq1ZDe0tomHC68qHk0roEYCQ3Bs4/E1cN5U1S+rMLZ9wU4Gqk8Zj9YWP7AuNVf2RwN+b7vgJTj4d+wduqLn9JaxxUheNak+PZkj3umfm/SAPG5ST85glHWGK/SQRthYT2P6Io6p5AS0RGMO8ugiMnzGJ+9Gt7pymXMfN0XV//Xg3M9iJsWJBRtgaLGESpsk8qKI25yMW7PzfPni70v6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757054056; c=relaxed/relaxed;
	bh=pDeM/jY+hBjAL5rrbniB6TXDCtopoaz5edxFNVVMF3U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YV9GC5rvMHzbv+VMzjNdH3VPBqA/HgQTdlaBPN/veU4LJrp3mju7DokD7GSjhY7wkG6E6fERT4R0FJQqejDStJvVFL6fnj2yJmXJp4HzZOCpMALQtbyPkR9vgnXtzB0gvaBFX2Zifc84zf+TMx97wu0Wgg8PYb1E2d1VANStdcmRAMQ/RMDHkKHaelPCJqMeAUqqOEs4rsqEFmLQUhsYZOdk4q7kmKM+ztlNjdUazy1oe036n24071UHSNDcmjnnNKuJMQOB/BlVrYooa1K1tyc1JSeEo9BB535fjclWngIF4F2tIdywuoGslWSUI7LWUmYX3YzEC6461n/X/NQejg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-59.mail.aliyun.com (out28-59.mail.aliyun.com [115.124.28.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ6536FWLz30Vr
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Sep 2025 16:34:13 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eY3NvdK_1757054048 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 14:34:09 +0800
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] erofs-utils: lib: avoid trailing '\n' in
 erofs_nbd_get_identifier()
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
Date: Fri, 5 Sep 2025 14:33:57 +0800
Cc: linux-erofs@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C6EC845-E77F-4755-BB0A-DBFD8C5AAC11@cyzhu.com>
References: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


> 2025=E5=B9=B49=E6=9C=885=E6=97=A5 11:39=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The trailing '\n' shouldn't be part of backend.
>=20
> Fixes: 5d3efc9babf3 ("erofs-utils: mount: enable autoclear for NBD =
devices")
> Cc: Chengyu Zhu <hudson@cyzhu.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Tested-by: Chengyu Zhu <hudsonzhu@tencent.com>



