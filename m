Return-Path: <linux-erofs+bounces-3869-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id shrnMLywTmrvSQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3869-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 22:19:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AC72A285
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 22:19:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MRWCP1o8;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GMXHvn3u;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3869-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3869-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwTvW4fv4z306S;
	Thu, 09 Jul 2026 06:19:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783541943;
	cv=none; b=DFZ5PHsSSAbp06pibQ8efk2XiaQFnwp1YHZRSMrPJB0dRP/AoGK9yFsG0s3O80clwy0ghdGvln1rcg6fGjdLxygCk37BrKVJ+iYNNyZLkP6JtAHI34+crNHgMVWUDxkcTrriLj+/TWT5Xt/Fv2XYyZ0zfb3LPIthIC0aRceRe4h0SXFqX6vNpT/Kc+AnBYyvInDSfnN7E81JriJSllbURZ5PDAc/FOeFdigyNtYKgCqPgyatzw2/MgUTDs+DgxcbX8C+WGWH2T+nmXoGOXCY9PFnCY0rzv16Hn1VFHmhwrIN7a0b2arebEC+Eo2ostvzlQ7dZ+QEAJFF2y6ZF+C06A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783541943; c=relaxed/relaxed;
	bh=OGpY+aCWdZdLzAr9IVTEaSTpbEI6iVGt97cU+sVsvo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+Cb4A67rWMwbUcUR0Z67FdXStEjaBBRt4xPePOQRNlc58Kff5qcluHGwF01nbR6kpMaBNGjRRJQvKkz13mpIFame8xschnJkYuhfJVga4ekI5ANMhnchA2gf/aPcM0L2eFEuuy3C7K3ieSUzxJc6jU7WD6/RVVeYxAA6QjiJUd8srqU8gNvTg5dun4hkGnJGwHhb9i6VCNP1jVR0apoVWGHxgVl6u2D1e2w8pWbo9HxfbUOUoIzQmPN1jplH8wT5tBluZdv38yCNaYohEWaf2wl7DXzts6scPEMlkw1xHx0iEnB8f/jqDHt7c/ax/6dB0wvQ4aKvhWvQ+9r6HyS3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MRWCP1o8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GMXHvn3u; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwTvV3QCXz2y7r
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 06:19:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783541936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGpY+aCWdZdLzAr9IVTEaSTpbEI6iVGt97cU+sVsvo8=;
	b=MRWCP1o8+qkc4HY/vYCKRog5pxyqcwFyzUd2/qVogrZADESkj2Lhonj74oSXSQIMeHnMw8
	8ij8itkkZSgQk6/EXOFIrvflXphL1MyWefeNouQGL/ThsEWKaMfRyueOJD1VlvKQf9BHxK
	FWOAF2/kYSe+ZTUjITor/o0WWWLbsMU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783541937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGpY+aCWdZdLzAr9IVTEaSTpbEI6iVGt97cU+sVsvo8=;
	b=GMXHvn3uFBQSQiPeukMmUWFxbGOblCok7f9cYGOLwITHcKTAzblx2CNLtWAKogpJ88aVqH
	YDmSS8qMbMhBhKbwz1y+Kix7pJdzDo3pLrgRY2I8/zNRGumkq4sfcjVSYYqiC2zVoskxit
	sCZKJFGj6VFA+BEjfvPFZ6fnnqnCbf0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-PDZBUIGbPQCbZd3K1nH1Ag-1; Wed,
 08 Jul 2026 16:18:50 -0400
X-MC-Unique: PDZBUIGbPQCbZd3K1nH1Ag-1
X-Mimecast-MFC-AGG-ID: PDZBUIGbPQCbZd3K1nH1Ag_1783541929
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61D4E1800350;
	Wed,  8 Jul 2026 20:18:48 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48D6F195604C;
	Wed,  8 Jul 2026 20:18:47 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-unionfs@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org,  Al Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Gao
 Xiang <hsiangkao@linux.alibaba.com>,  linux-erofs mailing list
 <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
In-Reply-To: <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 8 Jul 2026 21:01:53 +0200")
References: <20260708095831.3381978-1-gscrivan@redhat.com>
	<CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
	<878q7l8y4y.fsf@redhat.com>
	<CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
	<87wlv57dt1.fsf@redhat.com>
	<CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
	<87o6gh79yi.fsf@redhat.com>
	<CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
Date: Wed, 08 Jul 2026 22:18:44 +0200
Message-ID: <87jyr56xqz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: IRhUck_42zDFYUbwhNQ2_MAZ9DVWV8C6zHRQM7l9Kos_1783541929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3869-lists,linux-erofs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,szeredi.hu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD6AC72A285

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Jul 8, 2026 at 5:55=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat=
.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> w=
rote:
>> >
>> >> Amir suggested to add that functionality when I've asked for some
>> >> feedback before sending the patch here.  I am fine to drop it if this=
 is
>> >> the consensus although I see its utility from user space.
>
> I was thinking that getting the number of layers or info would be
> a good idea to complement getting a layer fd.
>
> I agree that the same information is probably available via statmount
> by parsing the upperdir/lowerdir/datadir mount options.
>
>> >
>> > How about a completely different interface:
>> >
>> > int get_fd_opt(const char *name, unsigned int index, unsigned int flag=
s);
>> >
>> > Enumerating layers would be as easy as passing an index stating from
>> > zero and stopping when -ERANGE is received.
>> >
>> > It would work for all filesystems that use files as options.  No more
>> > fs specific ioctls.
>>
>> Is a new syscall really justified for such a narrow use case?
>>
>
> I feel the same way.
>
> Giuseppe,
>
> Could you add some high level context in this thread on why you need
> this functionality.
> I think it's this composefs-rs work. right?
> https://github.com/giuseppe/composefs-rs/commits/reuse-mounts-and-prevent=
-gc-overlay/
>
> I must say this seems a bit upside down to me.
>
> If you want to keep a pool of mounted erofs images, you could do that
> in userspace -
> create a service that indexes mounted erofs images by unique mount point =
paths.
> Then you can introspect the overlayfs mount options referring to those
> mount points.

A first issue is that the mount options won't have this information
anymore, as we use /proc/self/fd/$i paths as lower dirs so we are sure
the fd points exactly to the file we have measured its fs-verity digest
before using it.

I know this can be achieved with a system daemon, but do we really need
one if this information is already known to the kernel?

Combined with listmount/statmount for discovery and fs-verity for
validation, the entire mechanism is stateless from userspace.

More in general we need a way to introspect overlay mounts to know where
they are pointing to since paths can be hidden using /proc/*/fd
symlinks, or files get replaced.

Another similar request:
https://github.com/systemd/systemd/issues/35017#issuecomment-2457333218

> Going through the kernel to get an fd and reuse that fd for a new
> overlayfs mount
> sounds like a strange way of accomplishing this.
>
> If the overlayfs mounter is unprivileged, it would have to go through
> systemd-mountfsd
> to request a mount of erofs trusted image, right?

off-topic but for now we are considering FUSE to deal with mounting
EROFS as it would serve only the metadata anyway in a composefs setup.

Regards,
Giuseppe

> Can't the same service provide the "is_image_mounted" query which provide=
s
> the mount path?
>
> I am not against introspection of overlayfs, but I'd like to understand
> the use cases before finalizing the uapi.
>
> Thanks,
> Amir.


