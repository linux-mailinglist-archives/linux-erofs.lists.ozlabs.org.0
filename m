Return-Path: <linux-erofs+bounces-1831-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCCD14E19
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 20:13:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqhqx3RWdz2xJF;
	Tue, 13 Jan 2026 06:13:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768245229;
	cv=none; b=YvQPzSHv2z39bXvljQM/O+WRqiKvcEf+pu788CyM6UQlTTOe9FHPx5v9XSt+YFU3oS0a0Zf+QD8lFwdEVvPBfzWOKbXqg8buzHpwOUlwhE4jJ1GUYlKu5zNiq5+9q3PeUU4WA8k88TV2ylkHskWQlhI0KdH9jEi325ECOupxOEH4LHl72/Jrx9Wm+FTz0P62trVqSzkWPnlP2w+vE6bd+EPtGT6ysf83yKZd6C62QLGYwGUEEu6fgQ9hijTsBQbSPOjHkEY+j3SqdyQX5uJqkFAeRYxjOz/yRee8SqRL0PVfBNELLso2z6CwQ74t6gXMb5/jOd4f3gX3q2Ob/ahkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768245229; c=relaxed/relaxed;
	bh=C7Iazn07BlU3KeyKwpk/Lh/6LTZKOYHbXLhopqmASho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgg0TypFbSXHNZstnLsmpWEvrvz+9VLeTWYh/QloxwGrW3keCtVYeCnaQ22x8tTQiVIzZh5aIHZCNxrKYemKFUZPvXm/Beb/VKMxbd2BM685FB74YT3lGMuXhd1v6SslUO8HeyqKfdpdU4328hiuNRnUbhaUK8HdGOAqgLhUMAFjl6mnwpqRsOi0n0isnUfM032Ul4Tt/mii2nOSwBpFybaX3M36M4XUnCnOWpvccN+0U+FogFpoN0Cg2TKM+N3Y6D5Gut/s8QkJLbaHHHFFktrgA0xUS/M0/HnJDae9Wvuvmvpqft7qbzJL4dViWrfPQPewjK6Depn7GXyWPRHH+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=198.137.202.133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=198.137.202.133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqhqp52rzz2xHW
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 06:13:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C7Iazn07BlU3KeyKwpk/Lh/6LTZKOYHbXLhopqmASho=; b=YZjsn1UPcJIXIVFSrthoKfcF73
	OuQpDbgQ5+PclN0GaVicHQGYXeuclRx1XYK8lT74EEDNPqfz9DRos0RuuKWp64AkYhNUxPv5+tZtW
	lxB1nJBa/biJbSRqHkgENMSDv71Mqp1Vld80mtOq3TMe6K3ObtkqCunIGlDjoEnBspgGAyxY9OHYs
	PE5Xe6oCr2zyvwULflE0ag4Cffl4mTWAiO1uMOe2Yn0s7saDgcobsRJkKeYtUtsh/7A8Ng3gw130o
	FzoVewjkdi7PAqN1l2FmrnNh6Hqul434ahEiIh/f07Mg26FBs+RQzwxvThSlRL5DNcQ/McZ661Suh
	6m/6FF6Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfNJz-00000005xs9-3ODZ;
	Mon, 12 Jan 2026 19:11:23 +0000
Message-ID: <f1a923f9-d1b2-484d-9253-99a2edaf41fd@infradead.org>
Date: Mon, 12 Jan 2026 11:11:23 -0800
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
Subject: Re: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
To: Nauman Sabir <officialnaumansabir@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kbuild@vger.kernel.org
References: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 1/12/26 8:08 AM, Nauman Sabir wrote:
> Fix various typos and grammatical errors across documentation files:
> 
> - Fix missing preposition 'in' in process/changes.rst
> - Correct 'result by' to 'result from' in admin-guide/README.rst
> - Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
> - Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
>   cgroup-v2.rst, and kconfig-language.rst
> - Fix 'needs precisely know' to 'needs to precisely know'
> - Correct 'overcommited' to 'overcommitted' in hugetlb.rst
> - Fix subject-verb agreement: 'never causes' to 'never cause'
> - Fix 'there is enough' to 'there are enough' in hugetlb.rst
> - Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
> - Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx
> 
> Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/README.rst           |  2 +-
>  .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
>  Documentation/admin-guide/cgroup-v2.rst        |  2 +-
>  Documentation/filesystems/erofs.rst            |  2 +-
>  Documentation/kbuild/kconfig-language.rst      |  2 +-
>  Documentation/process/changes.rst              |  2 +-
>  Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 



-- 
~Randy

