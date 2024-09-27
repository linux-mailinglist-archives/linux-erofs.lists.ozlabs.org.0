Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F562988CEF
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Sep 2024 01:22:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFmhR5YDmz3cRH
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Sep 2024 09:22:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727479333;
	cv=none; b=ozgAWbmct+Ht7s92U8eXMzXkK9IQh0eJWLTL8iMwqGf2XJ93Pg1uQIhG1jACg53ns0SGEjCA9sdqsYaQ/LIIsa/+c6vkEIM5rY1khFQoo7aUKecXzsyQNQewyOtSpbAneuTTGER1Q4m+GZvfDoa5J295mykrvwJdXSBY/OtB6lidc9rndmfoabABXNaB1B6s/nCRPsjMjVeiDDyhIu78j+OUT4e7M7YHmrwNuY/zwDPtSAc4njib9tQHiusiLTHxrbQxK/9UrH7ug8Jl5caRQHupD/fz1kYIZr11/errWmoaUvx3Qjniera58yomfZstXVZIx5b0CcqkUNGgMsfOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727479333; c=relaxed/relaxed;
	bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZeuRMtd3aCotsBdVr7hsIVWLyDjbyFGcg4jWLqm8FjL57seamh6yS/7h8BCQUwS3f2JiX1dHjGD1+XHQyQeXTqzhz84FNyP7st/y3iU8JP49jD9nr18rlYXCu8d0HdmvSin+YqTPAi3IrkyV9jpl1amrAm/zMxuipsw43BoQbsYrCKVHkaZQGvy3Vzq+5p9W92K8fE1oC/ffoztcYAqPVszKHrIed3fm1NedZjuYgjSz4SRGT2W+CuVX+LnEuDcZyZKn6xP3V51UZHQunF/1B02wr+8zaaMlVkqMTkW3EhwGicUuQbEPSCCJfz8TtXD9cn+3963lBaabgYMGiFgUEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l4STvVjK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l4STvVjK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFmhN482qz3cL8
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Sep 2024 09:22:11 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2053616fa36so34320605ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727479327; x=1728084127; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=l4STvVjKA7VRMj1K1jVp6ilicS0Kmz5F8TUjBmn6lTDUe5WpVmcCuz/RX+EGxF8Bs9
         GvL/w9Ggwp7SaugBU8B86QlLbUvO4ABhRtTwTL0DIRYJ2+KmWluOsX+9FY942RWeHoHQ
         SLvlhtSDcg8ArvytrXq/RaZKhmXL/0A5my/J7c2mTJdZamipjfWyWbT/GmqsyPfKaiG5
         xJHsh2m5zdwy9ywjE7j8pV2Qmd6NUWDzsC2HtpSZRYJ5sVZdvR0AvMB4eWoe2CFJUa3i
         4aP9DX2r57LMNV5yLOpyTYfLgHi6hrFb49EoATlOP01+WmH8ePkhcYOqprM+hMgJ8LoY
         M0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727479327; x=1728084127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=MOcqz3Zg8N75TFvfiPTn7hu5Wic5baJ8Wdn0aVgPU/OvzO1AEgn3H/YxNrhJsuSqBO
         QjyVkY1Hk3zSS/xLtcbcCWK3CSLgzDItIlfhce546EWHto0HG1HOiCZnO0SNkLJGKbox
         Ab1yFWCa9xfl4q55sCyaU8S5GUkvpfzl2SDRTyFykzdf82Tcn9FKAy36R9WeFDH8eGys
         JgEUqmeGpsF4nKKroMgFGl+KnCHqMxHiMS7ugvxINDd9jLGT+bTLjIEm0wFTpVdOz84f
         s+hyrWfAM+4CkizltOrvBUsZUEseb8mOSClfWt8lRd4uzq2inGkVhFeJt+U242yXRnIe
         j2bA==
X-Forwarded-Encrypted: i=1; AJvYcCXUtYAXoFrbo3USJdQ/N9fEpPW15S8nTOn7uXbqOjQrL2745QBE7IjCz2REiaU1dgimWCh+X8qpZLelTw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXh4rnXatEw9kyHMwa6x9YsNU88xghmIqk6mbQ48pMUCxL1LC4
	7lKgLeZ0xHiE4I9+3GKQFygdONofq/AwJyWxNW9C1W5CrLZ/xuG1
X-Google-Smtp-Source: AGHT+IFXTEMtPJJpJatKRUAfPM6/3maacD+r+Yf+RlOH8FPWHZYjxB+hsah3pGiJOGYuet3l4rSHvQ==
X-Received: by 2002:a17:902:e74e:b0:206:bbaa:84e9 with SMTP id d9443c01a7336-20b37b9b53cmr81601675ad.47.1727479326584;
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm18253515ad.238.2024.09.27.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Message-ID: <d87e3b4dfd4624d182d3d23992eacb7b9ffeff90.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>
Date: Fri, 27 Sep 2024 16:22:01 -0700
In-Reply-To: <2668612.1727471502@warthog.procyon.org.uk>
References: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
	 <2668612.1727471502@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2024-09-27 at 22:11 +0100, David Howells wrote:

[...]

> If you look here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> you can see some patches I've added.  If you can try this branch or cherr=
y
> pick:
>=20
> 	netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)
> 	netfs: Advance iterator correctly rather than jumping it
> 	netfs: Use a folio_queue allocation and free functions
> 	netfs: Add a tracepoint to log the lifespan of folio_queue structs

I used your branch netfs-fixes, namely at the following commit:
8e18fe180b0a ("netfs: Abstract out a rolling folio buffer implementation")

> And then turn on the following "netfs" tracepoints:
>=20
> 	read,sreq,rreq,failure,write,write_iter,folio,folioq,progress,donate
>

System can't boot, so I used the following kernel command line:
... trace_event=3D:netfs_read,:netfs_sreq,:netfs_rreq,:netfs_failure,:netfs=
_write,:netfs_write_iter,:netfs_folio,:netfs_folioq,:netfs_progress,:netfs_=
donate

No warnings like "Failed to enable trace event ...", so I assume it worked
as expected.

A fresh dmesg is here:
https://gist.github.com/eddyz87/e8f4780d833675a7e58854596394a70f

Don't see any tracepoint output there, so something is probably missing.

> > Alternatively I can pack this thing in a dockerfile, so that you would
> > be able to reproduce locally (but that would have to wait till my eveni=
ng).
>=20
> I don't have Docker set up, so I'm not sure how easy that would be for me=
 to
> use.

What's your preferred setup for the repro?

