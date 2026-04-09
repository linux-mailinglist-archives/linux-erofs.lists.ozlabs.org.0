Return-Path: <linux-erofs+bounces-3235-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NLcKqFu12k5OAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3235-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:17:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE733C8595
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:17:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frvTV3WRlz2yFc;
	Thu, 09 Apr 2026 19:17:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775726238;
	cv=none; b=PrMlZzGhmNwmLCRVUJburaRVAeYbN2Qz2YpamWKtm17lHiD6DA/fdSPwZphJkpOrRA/HCv2lMqxJRl5zMrCR6bZXd+L06MnICjzI3VlYtSZwcWOwkeMZIZsPOzJDIlu8sl/DaylMlM7OlYLe1bAns4UGiVO0dXPddAQ3aLKUV4TqyWeboijSM/7WY4p6skXHKOtbtzUlonAbrEXJgRm86ZlH7Tvg8I0CQNrpJNVsZdGKGD+p3b9CrBKL+r2WIOfCNBlHw0YKoI7/vVKUT0Oqh7Ckzb1TkGZpWBeRmywy8AAbY+Em8hJmNJLvitQilAwOu9GfDWc1l8E7JyaKV1T25g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775726238; c=relaxed/relaxed;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hzgo1DRo+fMN3ZgeA2NAidrvsBDuH+26OQx828/BAYv2XNmNbMi+DSx276sw4/8LdtAYtvRkYrxLb4btYcIxezZX79nmYgxGJCfXN3okcrafAaS7ZxDMD7kmJkeOOnNom4u+Xo/N454q5EhyQmyDho0SJn5+Wb4fH0TxWjs8QHOVunE1Z2k5MszJ9vnfttFd3HSqWy5T/D1ySvXL/lB+FrcZ4+L+hdX6ea9MmqtLHV24/bl/aHi5ZOku4hcjc3hkV03mhwdzCK7wF1qikYqIcvO7irkIoekKufA8dlp0wntPplbRXKzyi4TmrMMWreUKoPyx1IlqikOhDmYJa0zrcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cd+KbyCj; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cd+KbyCj; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=omosnace@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cd+KbyCj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cd+KbyCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=omosnace@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frvTR6gYwz2yYY
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 19:17:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775726229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	b=Cd+KbyCjTtrCyZY3ZF91sZaHJ2TxSFghE7iTZE0g1Ur1XNMK2mbFXF7gjIEXhI5escy+5s
	Wv+HFmHh5u5hOAXfE0i8K2o2JLg80BTZtiGXsqe4KU60w5UzhKspcu8kbF72M/NTCTvUPW
	jR8LiYglNmEF89Joo+wSOLeRQhy6ya0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775726229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	b=Cd+KbyCjTtrCyZY3ZF91sZaHJ2TxSFghE7iTZE0g1Ur1XNMK2mbFXF7gjIEXhI5escy+5s
	Wv+HFmHh5u5hOAXfE0i8K2o2JLg80BTZtiGXsqe4KU60w5UzhKspcu8kbF72M/NTCTvUPW
	jR8LiYglNmEF89Joo+wSOLeRQhy6ya0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-VpVguffcP2qOmFJUtpWLmQ-1; Thu, 09 Apr 2026 05:17:07 -0400
X-MC-Unique: VpVguffcP2qOmFJUtpWLmQ-1
X-Mimecast-MFC-AGG-ID: VpVguffcP2qOmFJUtpWLmQ_1775726226
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso7321245ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 02:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726226; x=1776331026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=NvEKthFrErCFiLVuFLNRIB5YH9GkDvtGTH+ZpLlIDs/bNN7Ymaub15FaAF9gNtlPhK
         +iH+bXNF2t+UUOFAE4BDUYst/kdfQSWf9tdzZztPUpqnX137AF6ucxXHybS0nW1sbDFJ
         HHwNP7VVTGj7/IxHfJikgs/3w+izWDgQYau5rpSsXO326k+3BJUfIuJplh7Ny7I4zeTA
         LAcCPTWL//k521F4PXsyICoi9hCiXW7Wpn7H2fIQ6AdAJMlIJHhSWV1vkcN9isaKI14x
         Aph7nGmy23I4j4/9ymIzCIAqcxLCTGqIafwUFDPfhcbAVi3oGv99vaf7KLX4czc0TJZb
         QB1A==
X-Forwarded-Encrypted: i=1; AJvYcCU/hCSXdXOQpau/9neSd/pphwds42yj+IhhQ5flWR2sVndVPop5gJyw59w6qUFSlQXYoX8HLpLzM0a/zQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLgbDDCcrglQI0GTKYcVh/OPMAPAHQykTkJ9wJMlSHcEeWsisV
	dVc01z6ThOe/iegX4z++vHmi1iPJbZh6AWxwdlJnhwIWSVB+iFBg3+7QmCLRwYuSaGNiU1ct7YI
	x+3eu5OuokU0bop84oDwW678RRbqyTvAbSB/g5nfB9bUbmIw1Po/8KLJ2R0XDR94XNjwshqtYdC
	CWDmzavbH1uLQuNXYbPbILpaO8ZWDa6CxON/7oCFOQ
X-Gm-Gg: AeBDieuXX2G1ZQO3CyCAp7zr/lulIVO1hebXnbCeJlXc6sKtUSzK4m2fXjqBwHnvaHG
	ke++lLEFgHkiVOCYYr44fhpNERpI2S9qAHWpgBi9j3n3lAQ7ti5+Kypkuog/icaXNZapLr7AVqI
	PyrFqW/EpSf1jNxJ8dv64cBDEq6DN+Be9p7o/9zMQAUqKF9gx+x1TAjVSjJyFueUuhUbqJh2awh
	8h2/w==
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b2c72d51famr29334055ad.5.1775726225897;
        Thu, 09 Apr 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id
 d9443c01a7336-2b2c72d51famr29333645ad.5.1775726225399; Thu, 09 Apr 2026
 02:17:05 -0700 (PDT)
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
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
 <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com> <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Apr 2026 11:16:53 +0200
X-Gm-Features: AQROBzC2DVx5qKVA4ihG0eixfkIbnn_9pZw2Pb18PXvqySFVij5lkBTtbkuLvjk
Message-ID: <CAFqZXNu3t2G6rUDToAH5CCRkHj-n_RVF4L51cmg0J+4W6T4D6Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VUU46D-2bavR_9y8z6yDQv9UTNwM6WpO7vS9OgwpY5E_1775726226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3235-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:stephen.smalley.work@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.ozlabs.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[omosnace@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,fedoraproject.org:url]
X-Rspamd-Queue-Id: CBE733C8595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 10:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > The existing SELinux security model for overlayfs is to allow acc=
ess if
> > > > > the current task is able to access the top level file (the "user"=
 file)
> > > > > and the mounter's credentials are sufficient to access the lower
> > > > > level file (the "backing" file).  Unfortunately, the current code=
 does
> > > > > not properly enforce these access controls for both mmap() and mp=
rotect()
> > > > > operations on overlayfs filesystems.
> > > > >
> > > > > This patch makes use of the newly created security_mmap_backing_f=
ile()
> > > > > LSM hook to provide the missing backing file enforcement for mmap=
()
> > > > > operations, and leverages the backing file API and new LSM blob t=
o
> > > > > provide the necessary information to properly enforce the mprotec=
t()
> > > > > access controls.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Do you have tests for these changes showing the before and after (i=
.e.
> > > > failing without your patches, passing with them)? I tried running a=
n
> > > > earlier set from Ondrej but they failed.
> > >
> > > A few months ago I sent you and Ondrej some feedback on those early
> > > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > > I've been using a hacked up combination of the existing tests, some o=
f
> > > Ondrej's additions, and an additional debug/test patch to ensure the
> > > labeling is correct.  It's far from ideal, but I didn't invest time i=
n
> > > test development as I assumed Ondrej would continue his efforts there
> > > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > > on getting a solution as soon as possible for obvious reasons.
> >
> > Ok, I'm happy to look at even unpolished tests - just want something I
> > can use to exercise the before and after states.
>
> Hopefully Ondrej can provide an updated patch.

Sorry for the radio silence... I just posted the fixed patch to the list.

I also pushed a more targeted standalone TMT/beakerlib test here,
which also tests the dynamic transition situation:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/overlayfs-mmap-b=
ugs/f/kernel/overlayfs-mmap-bugs

To run it on Fedora, it should be enough to `dnf install -y beakerlib
selinux-policy-devel gcc` and run the runtest.sh script directly.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


