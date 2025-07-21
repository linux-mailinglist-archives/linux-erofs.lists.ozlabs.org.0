Return-Path: <linux-erofs+bounces-692-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BEB0CCA4
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 23:31:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmD9l5DZPz306l;
	Tue, 22 Jul 2025 07:31:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753133499;
	cv=none; b=k3j4adOhxdMoegZwxENYZW6wyMzUFeXap2gJKyQ9MUJNW+0bDzmBfwy1CrUEIwZz6/GwMUjtc3HJ6JXLzo5L0VdzpES/rqIDE6loS6NFDDhZKEDkrbmIpivgLeuRZh87JjNdyhCLf7Zh+1MmnQvfagb0gqnmlTnewUym0GB5dD58099RNmnYSyhbXqlsNrbH6wyp5Sj0xVmLtXmh2rgy61sP0QGbZK1zsRWxLBp4WCHncn/F0QbiD1KnEslX9RC8hMfyeYLKWbHhPcavbnbit3JWD7d6PCe6pMXyiEgopEYoUUCGjKzOg+4kjOcm0UrX4xVJU8CJOLT0K2Zx8uG9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753133499; c=relaxed/relaxed;
	bh=8T8B4Jtap16v+NSjiTua6HgfSaTc7lZEvW2Hzt/OJTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMBFLVc24BczUyf4xaRyPyyHrTb4K6JXQ2z0J8Kdgn0tn84NVwt9LtNP0NyfWoeeggvtwJgurWT/G9SsXWO0r+sHejwE7jh7jc/PByWX8ckJVVXKifuujwrTPK1XE5n8cgTwJJOrXnbCXuLcZrKx2miNtDuP0PBwkDR/wK/oedMDz4SA5Kbynnm53tBM58hfU5hzr1nD0QNoHhKILwojVqJ+S3oYH37+8a/eFurUnuG/ohU3a2mQqm+iKbz8tT0Z0xt9qh5AU6Mh9rfFOLeGTRgg2h0hz4a1lb3q/eCy8A81OmRZC6XNHRmvVt0i8yvf93RKhY6/n2/H1EnGH6OoEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qz+GXexG; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qz+GXexG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmD9d3y8Cz2yRD
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 07:31:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8T8B4Jtap16v+NSjiTua6HgfSaTc7lZEvW2Hzt/OJTA=; b=qz+GXexGriEvIRcCUDnllLOWTP
	xgEDR13KbIg0XK4H5DoQ2ibi5m3pL6MZAOG7HYpvgWJ+FPgM42pNoD93mDaNGoKyNECRUJb1AaMzA
	L60rsrxOcRq7o8L/qPnHuGYWxkzgsRvEkGgVdfSbYp10Cg7UM04ESO5DpSAZLuX0yIX4r58oeT/1l
	6JECpD2xT8vaV1YVVCMfs3l390cu+T7DwZf0WoHcD79ISI1sSudsSSxCFJak4/C94LcwDbWimTU8s
	qrJ7z9pEJsP7kwt5LUpDvaTPGriakWuLmpjdDyNxM8vz2LJ6XlD2puUuUnYZV+2bgEfisuxnkiwLA
	POcwGJ+Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udy6Y-00000000jgy-0tGF;
	Mon, 21 Jul 2025 21:31:26 +0000
Message-ID: <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
Date: Mon, 21 Jul 2025 14:31:25 -0700
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
Subject: Re: linux-next: Tree for Jul 21 (fs/erofs/*.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Bo Liu <liubo03@inspur.com>
References: <20250721174126.75106f39@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250721174126.75106f39@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 7/21/25 12:41 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250718:
> 

on i386 (i.e., 32-bit):

In file included from ../include/linux/bits.h:5,
                 from ../include/linux/string_helpers.h:5,
                 from ../include/linux/seq_file.h:7,
                 from ../fs/erofs/super.c:8:
../fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
../include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                        ^~
../fs/erofs/internal.h:305:38: note: in expansion of macro 'BIT'
  305 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
      |                                      ^~~


Only super.c is shown here, but the warnings happen any time that the macro:
#define EROFS_DIRENT_NID_METABOX_BIT	63
is used (on 32-bit), all (or mostly) from internal.h erofs_nid_to_ino64():
	return ((nid << 1) & GENMASK_ULL(63, 32)) | (nid & GENMASK(30, 0)) |
		((nid >> EROFS_DIRENT_NID_METABOX_BIT) << 31);


-- 
~Randy


