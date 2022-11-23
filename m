Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57684636E00
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 00:01:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NHc7Y1kn4z3f2r
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 10:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZO8KT8PP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZO8KT8PP;
	dkim-atps=neutral
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NHc7S6dccz3f3J
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Nov 2022 10:01:24 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id g10so20155qkl.6
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Nov 2022 15:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=ZO8KT8PP+ynCgfpAsn0gLSY6SzCQhijyPIHusMskwtf9T1rrauFK8Ru8L7xDqiT98Q
         whp7Qv/cl82o4vi2+YEdK/JvvoG6oPw59CunYWdS4vec2yu+4W+UTQwMrh5IPxj3UHlB
         r/ebpwM/LCmalYllI981sk89ihQ71VnQhIaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=vYrbAze9rZ8rGJqGM8LdjyoyKSZfVEtsfBihLOpybc0ZsrwexUcYXQzqxxKpOmnoSe
         SWt2V6tCu3zxrZ33VrpOpRCfB2NLICxmi5bWLGh3lk55RjnkBrntkcv/jufTbob42WKp
         t7P+GQQN62bfI+nF6dzKpiZwCxPZT21nhrsVpuxxJK9ty02dO3hGv64LcxXiBnBn1+yH
         8YC5cTZ0dIbYO3bw/kX8MWo35DSnBXvlbuvD8cFulza6yV20aI5YuRhs20uwg++mvnOZ
         cawq53oOsHQWfxbd2kXDUVkfrErmP/BbzXiGqEBLoKQpKt5E/atu7Ciqg7G57+nBqC2F
         lm8A==
X-Gm-Message-State: ANoB5pktSKDTEeR8rgRVR88mdHA8eEuWG6wbvQ31xCpy7h3Mu+sfqh8h
	8428o35BY9xQQGeja17QIx5l3VOw4/WLfA==
X-Google-Smtp-Source: AA0mqf50e/Pd07iAuYZukDRQ0+hAeEFPT7nx9CWdFBRqHUnr4vSEjpF2nVvtnqMC6qnRR/9JGj4YqA==
X-Received: by 2002:ae9:e901:0:b0:6fa:2042:4215 with SMTP id x1-20020ae9e901000000b006fa20424215mr9474575qkf.368.1669244480240;
        Wed, 23 Nov 2022 15:01:20 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006eee3a09ff3sm13053887qkp.69.2022.11.23.15.01.19
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 15:01:20 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id jr19so159791qtb.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Nov 2022 15:01:19 -0800 (PST)
X-Received: by 2002:ac8:44b9:0:b0:3a5:81ec:c4bf with SMTP id
 a25-20020ac844b9000000b003a581ecc4bfmr16610980qto.180.1669243994092; Wed, 23
 Nov 2022 14:53:14 -0800 (PST)
MIME-Version: 1.0
References: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
In-Reply-To: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Nov 2022 14:52:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-erofs@lists.ozlabs.org, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Nov 23, 2022 at 2:48 PM David Howells <dhowells@redhat.com> wrote:
>
>   I've also got rid of the bit clearances
> from the network filesystem evict_inode functions as they doesn't seem to
> be necessary.

Well, the patches look superficially cleaner to me, at least. That
"doesn't seem to be necessary" makes me a bit worried, and I'd have
liked to see a more clear-cut "clearing it isn't necessary because X",
but I _assume_ it's not necessary simply because the 'struct
address_space" is released and never re-used.

But making the lifetime of that bit explicit might just be a good idea.

             Linus
