Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EAA0718C
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 10:36:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTKRH1H2Qz3bx0
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 20:36:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736415369;
	cv=none; b=maORngKBjBPyROiyvmXyYqwcJdgCrNXhTzS2LWQJstKyTk4V/8BlG8yzi8zVwdpUHf5pNSosqI0rCoNHuU2/4Ud4s2Y5r/VcAq9UNmEAJqQMy1lrcFr175/7L/wUlIdmgBCt7aUH+dVwlTFY6X3bJTQMSWss5Xq7ETmyK4Mq67JYb8d5kC4lmDLyb0k3tQazK9eQxgUE9tm0s/teGm+K1rdnZS8yHsJGMhHA5BpJq5dUwF2pJMeW48rVSahNMmY2KSqlZVRcIUEuu36Fx1itwj7qoNc4gdIodNfkVRWiE0/z3MziGldtRZDmncqibPoEm+3HI56q6fi9n2jIZhrUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736415369; c=relaxed/relaxed;
	bh=6MwReKcTHarIR7S+YzzULAVDYGwpQ0caN8D1g4Fx+qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJBzQnVL7gKqmf9v//4TgeReLTorDKyObnLewTzk/go0kOnUdyQInev93fkxDVpkoLbeo9UHAGjuJ8fNZh6d8yNScs0uLev6tVOOYm+HmRh4INPJh0HJUCVKcaNDA2oUF/M6Fi0EU9BsgmUt4KWDRchGNZ2MzBy5XTqzvbi7+Gmukoy1JVcxXbW5mwcniOeT/yI6l2ouqNlBWURYs+EE+bsBEF5HF3SVzjJ4nQ9to+AGpj9+MVkjNwKWmjO4Wl0+UL8o21wdkWPclxJYjqcCBxFCzG/StkBHmMkvIHGBfZMuLinPd0CPYf/Uyeuc8CNs+LRGroQyH4YBn6DGlJQaOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ctH/anJ3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ctH/anJ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTKRB3FQHz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 20:36:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736415357; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6MwReKcTHarIR7S+YzzULAVDYGwpQ0caN8D1g4Fx+qo=;
	b=ctH/anJ3gu0dS0RCHCWbvrdY+LEJkmrJIPdlJVQ0m689EIFAFwRe+WtTf//js9tK0h6jhmC0+lWEeZy2Bc1FfZ6HDQFxhv08lHobjV9BRdTQScSc5aizelxKUHoM8FbgIqLQIWbq/con13iKw/FG+YfmeLuOAXSMDhh3QwoJYac=
Received: from 30.221.130.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNHBp.N_1736415355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jan 2025 17:35:56 +0800
Message-ID: <23f6b78d-513e-4044-9e39-927db2cea53d@linux.alibaba.com>
Date: Thu, 9 Jan 2025 17:35:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [feature request] extract a single file from EROFS filesystem
To: Daniel Erez <derez@redhat.com>, linux-erofs@lists.ozlabs.org
References: <CAP84NrvY7nfYOdS6KbGeOCwGTKAdoNbgsu61S-YQj-3Bt4bCEg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAP84NrvY7nfYOdS6KbGeOCwGTKAdoNbgsu61S-YQj-3Bt4bCEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Kaplan, Alona" <alkaplan@redhat.com>, Linoy Hadad <lhadad@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2025/1/9 02:14, Daniel Erez wrote:
> Hi,
> 
> According to fsck.erofs manual [1], the tool supports extracting the whole file system.
> Would it be applicable to introduce an option for extracting a specific file from the image?
> I.e. something similar to the '-extract-file' option available in unsquashfs tool [2].
> Or, is there any other alternative for extracting a file from an EROFS image?
> 
> [1] https://man.archlinux.org/man/extra/erofs-utils/fsck.erofs.1.en#extract <https://man.archlinux.org/man/extra/erofs-utils/fsck.erofs.1.en#extract>
> [2] https://manpages.debian.org/testing/squashfs-tools/unsquashfs.1.en.html#extract <https://manpages.debian.org/testing/squashfs-tools/unsquashfs.1.en.html#extract>

I will add this later.

Thanks,
Gao Xiang

> 
> Thanks!
> Daniel
> 

