Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87698AA33
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 18:46:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHRmq0gp8z3051
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 02:46:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727714808;
	cv=none; b=mit/x30SwqThPdTDuDlo8i5dRBNh+s+PTkVM5XE+cuIuwfpTUII5Bbr3gdYP/Gjvz28sgLt3BXiJkWIZsZ6zQM1f4hG/8WWuB1C9KHy5T/ogPPkZHr9QXJuWcswD99EODDO7kTUPHdnml++nfriC9mk35MlqedztTL5dZesoMZAFNNm028G203Q4Py7yGeISL7kv5x94AW0OK6oyE88gOth47tdGPyF7VC0S9p6kaNLInp1F0lsCvq4Czm20rv7e6Jm7CFi6hL+fvQImwYOkTHtX8ugDc/8pdUyhiL+NEXtrgx6IBp6b/9ZPYdA1TLogr+sLuhHAqrHuXPd6XxsFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727714808; c=relaxed/relaxed;
	bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6iu8TnMdm1FsaPjil2Wxeh48DNasu2P72rL17Cic4S6XE//hIYxLFYqbY74qKuQQibQkdsPCTKZz7h8z8usqsq+OdpB0+Y8O+eXk8V8qwLwo+2eURdFpo/97IUB9iO7mpp4CgDcElvkR2vEOz9RSC1r4X0Q9hwDn2uafPEWnb+Hkfclx8hxiPtd2PW/xemJ9kjzTlk3qvuulBio6pnOu/8LxbXnVffdb5gpINTMbAeqjfj9QifBKk/EiL1s4F2ezyG5V1BdyZs4a2DtxyGbb5mIH5jUYkJPwkjIh4e+svbpnFD6waV5ytUBOHL7bvV5KPJRb40a6MwCkpDNzJOvJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LisNooYv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LisNooYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHRml1mDdz300Y
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 02:46:45 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2e075ceebdaso3401752a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714803; x=1728319603; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=LisNooYvGYrT8SdUkdU2sOL00C0qVzgVjpV5lkRpC3efJddhoyGDMDGBJcxq6lnt4E
         CtwiAzx/de3QjULdYi184Z2qk+ieTM/n2JVe5iXoMiniVQq5p1JdxJtNB8uavqfuy4Ns
         8eDhn/o5ZZWOgSv+THy1Ih+FSn7qSW6NXGwti7JvXPw2OhOH0zhedeovxiwc5bPMBUov
         8hQl3JVvVpDysn7wLJiwAQf5YAWJtXMDRpU7mBfQRsXPw4WjPKGuSJXl8WEMAibkTng/
         byw5ppE5E1aOdYVHp/+zPX7lU0AM3nQG+2YACDGxfrmXhdTOmCfPQEr5lEGOck+iJCYV
         N6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714803; x=1728319603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=uq4nTPREO4EMUHHOacIYe3Kg/XYRK27gcRqvUJjoofmovGYykNTw2y9DNLsNj84VxG
         jiXRNl49i86yV7QZtAoJudizJuXV83lPJlEhrp79733TqCDhPg5akUqo4uxrGuPnj5sF
         U5pf/mftVaUYLpnpgjd7cfeejmA+AhmKeBWGR3Wzy/qcR8pXL7hs+2artj8Ao+NcrZtd
         nfXtlxcSJXjjbCnyAQdt3bUTqb7b+1/eQyMVxICsy255B7JMkE+oj6DEwvhnTYgWXmaI
         fCROUjVWv+qXWz2OzUiNqRHkq16oqG8nAIcynaRVzH/wEU1CHOXuB/e4lwv/Bmrz5W53
         6LNw==
X-Forwarded-Encrypted: i=1; AJvYcCWKaImQw8gymhZBAIw/Pgc3yaj8OxJE4vM252YmrM0euHj+Y6j0QT6DSYCHKtg9c4M116NR0w6X3aCdVw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5sDW9F/gRKT467goCC/Ci7ResBQGr4v2UVo50221Q8nN3U911
	INWDMY11oadetPYP0F7SivtF2pqpQiXLywRonjSCjoNXIaihtEuFQn26WbUF
X-Google-Smtp-Source: AGHT+IFZC3EJ0qzaaUHzbstF3Ibe+95zgKik8WWlYGIZbkQX0EKejoD/dNihbdBEqG2pUNucAQRStA==
X-Received: by 2002:a17:90a:bf03:b0:2e0:a28a:ef88 with SMTP id 98e67ed59e1d1-2e0b8eeebe9mr12068969a91.41.1727714802654;
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c9d354sm8211290a91.25.2024.09.30.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Message-ID: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Date: Mon, 30 Sep 2024 09:46:36 -0700
In-Reply-To: <2969660.1727700717@warthog.procyon.org.uk>
References: <2968940.1727700270@warthog.procyon.org.uk>
	 <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2969660.1727700717@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 2024-09-30 at 13:51 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>=20
> > Okay, let's try something a little more drastic.  See if we can at leas=
t get
> > it booting to the point we can read the tracelog.  If you can apply the
> > attached patch?
>=20
> It's also on my branch:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> along with another one that clears the folio pointer after unlocking.

Hi David,

dmesg is here:
https://gist.github.com/eddyz87/3a5f2a7ae9ba6803fc46f06223a501fc

Used the following commit from your branch:
ba1659e0f147 ("9p: [DEBUGGING] Don't release pages or folioq structs")

Still does not boot, unfortunately.
Are there any hacks possible to printout tracelog before complete boot some=
how?

Thanks,
Eduard

