Return-Path: <linux-erofs+bounces-1416-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CC8C76E5A
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 02:54:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCJF54jbcz2yFq;
	Fri, 21 Nov 2025 12:54:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763690089;
	cv=none; b=ltw2f0z/9F8nZZnhHlYVBYXAhNsO/bfOQLYS/JBuLX0/sQDosH4LRptcPDihdFZZkBPKZCPeYKWxz26QWc0RH999X9Dj8e86dNyjyrj48wp3aKPhDtx7TCaNtiCnqm+DZpgzvRFR4tlGtJKo+yC1d8BOpdvFuYD+uD8WgEqRsS7UVjStJYuSn2ox2AwnOiXVUWqkIjEtCSf+EFcOel1wfaP+nBmOYqi2Qx2Rnt4FvlvqNIzejlq9Newp1BQVP/Yij8j0nJjYN9MxuDOUiy4jVinTXTgv3rmRNCMkMx+aDPFdr2RRPhDlNX9wLpqlro8P+iCWwbUsJ2CC/sHFI1cPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763690089; c=relaxed/relaxed;
	bh=mjXzwlPQuMvwfuoI6fyn1UE0PXw5yR0XdOPwuz9JfZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KyOTWEKjCu4B10dffkBT37VITCrtLcXYOiGz5jyrqLab3yZGLSQd9usEG7Z/pYTvuAiLITSFTqmnxApW8YfldzRgtMOHYULVyqNdxhpAIS2KxDbjXLsaXoRqUj2+dtt2vjPf8zAOAgwO5R6Fcxic+Jv3sGoCM41K7bytJlGJI1kWB3Bkps/nlWwVWrdBZQRb5NPsisxCwUY6tPUnigmtE6OEXAVuTX5bzSHZtk05lwwZpJylNKYvnIiAdhGY+bJlefi22N1cgPDAtHwC05uUPmnuqIOEGp6k8hLZ+OSyJzl2w7AI7KpGP1VmjuX1FZdHz21T26fB2LlZJqvMrQD17Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WrnK8NHt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WrnK8NHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCJF33sLwz2yD5
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 12:54:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763690081; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mjXzwlPQuMvwfuoI6fyn1UE0PXw5yR0XdOPwuz9JfZU=;
	b=WrnK8NHtTPmJe25VDPWP0ip2jESxlMSmZzH1WlpJ3TWOll4TL17SoeVvVKgrBxdN7lV6V8oAwLkXNEjLXmp7DZF4d47DDyY86OBvSBAs/eXIB++kDEMnXCU5YGQtnoxjbfAhlkIIdEoq8PPrU5Dpvgl/CtGDLb65tgbbix8wPwE=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsyeYvn_1763690079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 09:54:40 +0800
Message-ID: <eec31850-c012-4200-8a0a-4dff5a901720@linux.alibaba.com>
Date: Fri, 21 Nov 2025 09:54:39 +0800
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
Subject: Re: [syzbot] [erofs?] WARNING in dax_iomap_rw
To: syzbot <syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

#syz set subsystems: fs
#syz fix: dax: skip read lock assertion for read-only filesystems

