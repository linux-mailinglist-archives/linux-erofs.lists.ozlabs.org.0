Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54256A14A63
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 08:48:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZBg71dcwz3clB
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 18:48:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737100098;
	cv=none; b=cSkOvkHOpYHMQZmbvYBgNaHDPQyibJi6arib4xVJyrm+Vo5mtBmA5lR7DesuFeBAcVn6N+HfgDqF3pTJMpmNhz4F7xTEkRFYSOUtvaaqBu0Mg4hKGoCUKsg99sWrvkHRCTrqp8eEY9c0ea/T6Y+e5lKiPeo/DO3A2Xv3qt9RW0RCHgex3UPWgzPVpBLXAottR0Efy1xm+SNFxlb0TkSpkwGfXRSDjqr5yUWnIeZCSPL5O/Fu052nHafxTywJKvIDXus+CevBpAnUiPLj6ogslY5D7t6vZ7tv28Jq2qjlNrR3wTGmLaDlwrs0yRyrAAJEGghvJ0b4TCdOmhgkw6ekBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737100098; c=relaxed/relaxed;
	bh=6G6LvG13FcRyNj6p4QHscNK7O6KnQHMom3fB9p6jylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh238h2I3mQ9HL9LHiijzFYZyk3vYBWbOCiZltdo+C6YzNcMY/YioMgu5aYIa61tYjCmJvRZG61u295d5JxnjbJ6I8J/n3ATrL6XuE0QX6VUKJk5qYuG1Jn775gUMwOHKmZy5D+5tqGAXeFAW2oL3firlXUwUK/txOCnBf0pASECElH+OZvYz/vw0nqJt6vUSjUxlqgvye35TzaKmvIXSxKRkz1f24vIl/e3hb0axJ5FOvOe8U1FLtd/1r++3/GJTvG/R0HPTVdOqZ6D90Bbffn7V4uDEDeR7tDaeJv9IswUobmsFefG4FDTZBzTKyebioSILru/wjp6yt4I9IlYBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hAjUWCjl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hAjUWCjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZBg54LV5z30VX
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 18:48:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737100093; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6G6LvG13FcRyNj6p4QHscNK7O6KnQHMom3fB9p6jylo=;
	b=hAjUWCjlu+hTsWZHig3Pra7+RJ4wgzYuTOtbtcMFJtCi8tC+8JweEGsZ4u4RQKoAzr7qR60NK5rULo+8SgIGxvhZK1It0R4LSUgacGw8KQsajnKbbgrYw25cLyUfGimYAG/Stum7wSlhNithjO8MndLW1uLgGcWoS+tSXeg6uJA=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNo9z.h_1737100092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 15:48:12 +0800
Message-ID: <860a49c0-a41a-4028-8ba8-bafeb38f1be5@linux.alibaba.com>
Date: Fri, 17 Jan 2025 15:48:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] erofs-utils: introduce fragment cache
To: linux-erofs@lists.ozlabs.org
References: <20250117074602.2223094-1-hsiangkao@linux.alibaba.com>
 <20250117074602.2223094-3-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250117074602.2223094-3-hsiangkao@linux.alibaba.com>
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
Cc: Li Yiyan <lyy0627@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/17 15:46, Gao Xiang wrote:
> Difference from the previous Yiyan's version [1], it just uses
> a tmpfile to keep all decompressed data for fragments.
> 
> Dataset: linux 5.4.140
> mkfs.erofs command line:
> 	mkfs.erofs -zlzma -C131072 -T0 -Eall-fragments,fragdedupe=inode foo.erofs <dir>
> Test command line:
> 	hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "fsck/fsck.erofs --extract foo.erofs"
> 
> Vanilla:
>    Time (mean ± σ):     362.309 s ±  0.406 s   [User: 360.298 s, System: 0.956 s]
> 
> After:
>    Time (mean ± σ):     20.880 s ±  0.026 s    [User: 19.751 s, System: 1.058 s]

An in-memory LRU cache could also be implemented later to
meet different needs.

> 
> [1] https://lore.kernel.org/r/20231023071528.1912105-1-lyy0627@sjtu.edu.cn
> Cc: Li Yiyan <lyy0627@sjtu.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

