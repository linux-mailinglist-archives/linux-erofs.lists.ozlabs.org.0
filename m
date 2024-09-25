Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69792984F3E
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 02:01:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCxj30w3Nz2yRZ
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 10:01:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727222484;
	cv=none; b=F8REHyWASBjqnrunPtQOfcOD0v/Uwv77WQ1fW8k4RxdJmx2EusZNlNaC07GVzyK6R+Zkushs4kbnwkFkIcndCMGjuirgmOF5eUzzHaue0zz5xGKSraT+JHepaPzuRfH/8VqM9A48gdAMaIERrtXzmJBZ2HATfSowUMh2t971nq9+ZuxP0XFyyZsX6khPsfehNBYPJVFutQuVpVLHhP3hUfdabmNVI6jhFA7MZz5sdGJHRDMZU5+TeMKJtHlK6n+RMpFexaYNT5czbuQWVgq8mISuTtcQ8l+mFf7k+s9DD/QFpTgMrIaXB5n4UQOzDFVxzgY+15fuRsh2eQiF3Gm+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727222484; c=relaxed/relaxed;
	bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWKgBSiZJsIVUvZuwXKr88r/sWLIhvsFp3j6nJzatusjXRIYKKpbK1IP3nCPOjGQWpiLVtiCU2JStWZLHW6LFoHx9vqBOsBg6EuxSbfan3IVvoGJdvpcAr5UMQfngTaSCAmZG1z0J8o6pC1WOPr20VKpjHl4zWkPnfNGYCid2sTJwz2Z0NVC8MgiLZG+cChjWq6jTsrs4dPtFSAO0clKE4o+DbjGPayk/fkaZPTVsKiSIVtaRFzMBL2j8UU+02QpInSnCzwM8DGsjQuIJzsNmWVWYL0PARLJ9YOdrcBiyDEOzuRVqXdoFBTG7ccPJuqBs7KnSyLhmdoPN/DEcDgCxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bBVdv2lq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bBVdv2lq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCxhz5srlz2y8V
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Sep 2024 10:01:22 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-71afb729f24so995017b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727222479; x=1727827279; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=bBVdv2lqFN6tat9rI3ZkCzMJEiE+uPlGSMOHFVTuembJ20JpUfk2lH/5KwbCIXucdp
         YTVz/TuhBIv6rDJJajCga7dgzV7InXykuzXJ9hZ+SIl7RVRdyfFo8DmHF0mcSSNop24K
         0B4H2ZNQU7T5HDZD7VzfwNmlVdwtVOktGGhTH8UsUMFpRXIX/JWRWozNyBQ87YqD6KIx
         TCT48a1mpUtu5B10v8oiu5yxZS/hpGDbsdl//rITC4HbnFURtXXyg+960uBzXV7boYWs
         69N2x5g23IV5ULGjIK3MtgcQ3y14+00lw2cgmxH1qQA2Febl1J6vQOyDFrL0b49MvVL2
         m/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222479; x=1727827279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=uFItsiiCGeAzfzzVMXesCPMcemiH3a42N7bTytb/XMUve2xj1YdiVJq79o2uJ3qUuy
         1gz8wCdKkuO6feqUi+K445QhRvdvZklg729FEVIknrC1drXPA8CAKjLD6+czRQjIME3h
         itSaikSX41Q/8yvU3qbIIUH+uzgi8sM3Lv6Tq0dq0HtA4mJcAD6zCAQ71LY7sKI5JxF4
         dDNAzBQiNt2GcBoAca2cM7184xlRVL6Bq0ie2cNJgls6sWN508oNM7S5F5RssXGkHhbY
         67+bKUTIZv1oue0t5FvTH0z2YqeKb2dvhSSmmD9m6jLH8ltKX1gD6yPnwkpdmQhYO7GT
         jb2w==
X-Forwarded-Encrypted: i=1; AJvYcCVafc545sWb5NgPqmfxd/5SkXQzl2OK9VvYYtxLOLNuCuj+TGj9Dc4XAoOcvPVHsdQ2+p4Ta0DqJlHAbg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3ihP87onLDHMKinx/OyaqMzUEt5no+ftQ6SMnHR82/P0P9A1j
	SzT6z8Zjx34IVKGQcZxdlgy4xoB7rvCkaoVUQ5Wm8gPvRu71Tu4t
X-Google-Smtp-Source: AGHT+IFvocGse94WXxiZf5ejfW8ZMZrfybKRDozJJhDfTj+R6qo5a3bNsb79W/etWWrqI4tOhHvi1A==
X-Received: by 2002:a05:6a21:e8e:b0:1d2:bc8f:5e73 with SMTP id adf61e73a8af0-1d4d4bc0cc2mr1117741637.38.1727222478887;
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9cbc02sm1675483b3a.213.2024.09.24.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Message-ID: <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Manu Bretelle <chantr4@gmail.com>
Date: Tue, 24 Sep 2024 17:01:13 -0700
In-Reply-To: <1279816.1727220013@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2024-09-25 at 00:20 +0100, David Howells wrote:
> Could you try the attached?  It may help, though this fixes a bug in the
> write-side, not the read-side.
>

Hi David,

I tried this patch on top of bpf-next but behaviour seems unchanged,
dmesg is at [1].

[1] https://gist.github.com/eddyz87/ce45f90453980af6a5fadeb652e109f3

Thanks,
Eduard

[...]

