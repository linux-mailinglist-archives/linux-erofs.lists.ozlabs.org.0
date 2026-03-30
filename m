Return-Path: <linux-erofs+bounces-3102-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cII4DMYaymlR5QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3102-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:40:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26D356044
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:40:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhSd0J1bz2xpt;
	Mon, 30 Mar 2026 17:40:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774852800;
	cv=pass; b=M304Fub0frbnLnhNma3zcWEEIK37tQdRiLoOGYinpLPBYU75+h28jQbm3jAQAlCQ2kJicRv4fEuHJ9xY/1ECIWhWJHG07yopE+sFZr8lOgsT8rUss636DiThDRDEeVeQPyp+FsMEVqCvv4/aHJRcm1rOb6SLi1ebNnwekqYZkaRjdMtVgaGdoektQSPAZVFu8v6ukGvG2GHKuED6TAeeTPCYMM2C9H8jH+04fZi5mNG1IFdI+3gCHPstGBPEAnonvxViRlPZZU6TP0QNBQn5Jeem1xycVYbT7S2qMhZKksT1YOal8We/wOwuvrANe0gGV4p1g83/Oyf3IFb2H2370w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774852800; c=relaxed/relaxed;
	bh=sqqEhcq0X782dTb0ZC6Ihxm+bQ7NmbWThKiojwCcnpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRBsdj64kE45FVbKF7vVFOdj3ynzG2Bk6mL9FrK/iKN3tZBt8Lr+LIpR3MdgJEQKq72bytR6JAo0Enh9PoYYp8Cq2A8kjU0SoXduKugoFrH1CuAqtWnFX7Vld+c3zVPSllRABGpnZQNi+nKRWEkMg0YCSvET4rYkKkSPdZqizr062L6SKfsvK0z2Fv0QvT4YaLILADxmq1CgdXCjAEGHHEZXSv37moUNZQGaXFP47Jvfg9cA0Th38FczQB9myliQIukHlBhTohzcVcNegirQXbQEDlU4zWWkiolNnIaADJEbYJtGnSgfhes7H/hfjsAzG8mBpoYa+lfKBPNcLsIAUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iQ7SlX7V; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iQ7SlX7V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhSZ2x9Rz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 17:39:57 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43d03db7f87so65496f8f.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 23:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774852794; cv=none;
        d=google.com; s=arc-20240605;
        b=RKNhNVw/5gd693sebHuQjWrYmusDmEE7BT66Z5u71vcE3AiF8Q9GJA5PYPe35kkL1G
         MrG020yO7vWEjX70/6DMBlLHDflK6fupSXG/gunXJ7LLDDLKM1cAMXndWmEZfraABTwr
         2ufPuvOJGte271uvqgHb5BnxQrGcLHMR/u054VseBezCyQqK09QOJZEJs6ad+xSFc5Q4
         1tYpSuoK9luVPlNueaeMH1J5DmL47mHWs0HiR5lzj17r3ZkDnx9j3hBARvymcQmCQ/Ay
         wJWQSGQSzDcs9C6DAdyZokC4fh351R8TyzSYIz/D/mDlW6zgdNzkLGXOM8JxfssReryv
         9naQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqqEhcq0X782dTb0ZC6Ihxm+bQ7NmbWThKiojwCcnpg=;
        fh=9Wn/3jJ7cxXJ0f0APmYc1WKS3OekWYAY1EBckSr/YzQ=;
        b=kodp1oX5P3DlkpsAu6CZtp8pYTrNQhoAjaisIV+pk4E8pckp3Awrc7Pj8bp+obVXpZ
         xM8VZvkpJcBvYdzrO9OxzN9X4FMg2pvYa6usmhT98S/DBvIFo4aVhJyXH7hoVFodhjJx
         fttFQ6GQqzKkbU+BNvKsGtzaSA54tEy/0a8qmjkApm+Rxtw4Iv7r1FSjljSGFvMii2wU
         I0Vnh6EIJ57zSRukCz8ea5pNJzpFzAXRa8juK2pZjSdOF+98Lmvr7GZJJ2llyggy6QBa
         BrvuPhSUAUM/YxTL4TZ/vm8PURVG4b6RjfVFLQrBH1VBIPjedOShF6uJ+BXvh2NvqZFF
         EpyA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774852794; x=1775457594; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqqEhcq0X782dTb0ZC6Ihxm+bQ7NmbWThKiojwCcnpg=;
        b=iQ7SlX7VEMP5/tI6yswdTluXt+bM4G3zjlk8FYC+zVI26Sq26bfi4tfdIEcTPd7BAS
         D/UDsy2Uz6l9z2U8Nh8tEq17uI0mfYMZV9THOowEuxYYca8xkoD9nsjEbbUX5O8F+imm
         wPCeN/HCqUf8G4zKo/ycbffa6rk8qtS5ohMJp148bAPqUimX1MUTfYQOaQxRZuycyeuw
         OHjmqjaa92upqOZq2RO3ocyDAPjzDGCd598rjLk0UZFux81LuO8XWuvaOfcJUX5fNuIc
         quK1gN2HrStE0KDjcmzFnKJ/HC6iAu1vJ1xfP+Q/QJw2cVZEN/rkoibrQYA6qzucisA3
         XL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774852794; x=1775457594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqqEhcq0X782dTb0ZC6Ihxm+bQ7NmbWThKiojwCcnpg=;
        b=SKogCENOM1bA9VCoiWC1r1ryn61E2cwwb+9q4l9o8NE7hZxDeuRxVF+Hij1qzP3rjs
         6AIBT9Mqrt/TTiAkjsUga6e3Bz40QzAJjPBhzsDp2hn9C6NhqxhOcnZPARD5Zb3/dvzm
         pe3z2I7GAoR1q6pD0sX+4QblQIZwDf568r1UN6x3SnwnFNYhWU0XqHb096eIEqM3smRU
         KJ8UM9FMCkuNXU6BgvTFtmzQ2oCDIw66FyaPWewsWYvB4mdqWmwOwfvMLCeq9W5FycKX
         7LXZbndHv5H5YHxJmCxvVU3MziHaId+OaybmIQdXMwS+wQbBri9luppXCTStOT0oXASk
         sh9w==
X-Gm-Message-State: AOJu0Yy4hv4VRVIOSgz4dga4vb6iD8jTcBu+wfSUW+sBeTv9aHlR14WE
	5bnAI2Qj6i/iQpI5+tYoy462N1hK/FrlvODDCrFzn7/qJ7EruY+b/P6x8oigwcxGN3gPynzQGs/
	1u5QQrfXV6toalJMHq4edwF+3Hsnbnd8=
X-Gm-Gg: ATEYQzzKjsFrmKPY9QSDyZm7Z0aOGR4iNGmuQQLLQRYmI70YAV6OCJ4wPyA1l5ntIQ5
	Uj6w07lXr45ZO26LjcT2dgGdKf2sfAV6Tj4EXz3A0+ALkPQtiqEPR40xGy58De3YXL2bOo9UT/r
	jhl7MB/2DW+Bh4YbGN3HqMDJ4bD3axGSeJWWNJaQq/ETNhplokVphvaTvwszT+/CoyB8+bPHlLK
	9vyaXDpdBzeKq5hOfDJsqkLY+dzIbfsPrdXQbYhNqLbtTs77IXLY9PhF6/dC17X32nc/GSvvgs+
	rw2way9bF2mRfqGtTPpfdH+xLFHxgKF7A5IOfbyz
X-Received: by 2002:a5d:5f90:0:b0:43c:fdd9:1890 with SMTP id
 ffacd0b85a97d-43cfdd91a7cmr5262971f8f.51.1774852793548; Sun, 29 Mar 2026
 23:39:53 -0700 (PDT)
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
References: <20260330052127.9173-1-aghi.saksham5@gmail.com> <20260330052127.9173-3-aghi.saksham5@gmail.com>
In-Reply-To: <20260330052127.9173-3-aghi.saksham5@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Mon, 30 Mar 2026 12:09:39 +0530
X-Gm-Features: AQROBzCoOOWcsjITaCz-0hz9lItRb7bQNabp1xSp6P-45BSH6GyYRb5maLREhM4
Message-ID: <CAMhhD9hpaExN4VEAqbyJfuNpscquz_OysZawM9usFPE_fFX4qQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] README: comprehensive refactor for clarity and professionalism
To: Saksham <aghi.saksham5@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3102-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,erofs.fuse:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,ozlabs.org:email]
X-Rspamd-Queue-Id: 0D26D356044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Saksham,

As Gao Xiang sir mentioned, patches to the README are not being
accepted since it will be superseded by the website.

But still here are some notes on the patch itself, that will help you
for future reference:

1. Commit message: Body line " first impression for new users while
offering clearer technical context" is 75 chars, exceeding the 72-char
limit.
2. compress-hints: The rewrite truncates the hint-file explanation to
"and so on", dropping the documentation of how the default algorithm
index (0) and the /sbin fallback pattern work. A new user would have
no way to understand the indexing.
3. erofsfuse description: Changed from "FUSE daemon alternative" to
"FUSE-based EROFS implementation" . erofsfuse is not a full
implementation, it's a FUSE daemon that provides read  access. The
original wording was more accurate.
4. fsck.erofs: Dropped "compatibility" from its description, but
checking backward/forward compatibility of image features is a core
function.
5. -Ededupe: Removing "due to limited development resources" makes it
sound like a permanent technical limitation rather than an open
invitation for contributors.
6. Heading style: Only "EROFS Filesystem Overview" is title-cased
while all other section headings remain lowercase -- inconsistent.

I hope you remember these details and thanks for the efforts.
Thanks,
Ajay Rajera.

On Mon, 30 Mar 2026 at 10:52, Saksham <aghi.saksham5@gmail.com> wrote:
>
> The current README contained several instances of awkward phrasing and
> technical descriptions that could be improved for better readability
> and professional presentation. Specifically, the phrase "form a generic
> read-only filesystem solution" in the overview section was identified
> as particularly unclear and has been refined for better flow.
>
> This commit performs a comprehensive overhaul of the README file to:
>
> 1.  Improve the introduction: Rephrased the EROFS overview to clearly
>     state its design goals and advantages over traditional read-only
>     filesystems, emphasizing the balance between efficient compression
>     and superior data access speeds.
>
> 2.  Polish use case descriptions: Updated the list of typical scenarios
>     (firmware, container images, Live CDs, etc.) for better flow and
>     clarity. These descriptions now highlight the specific benefits
>     EROFS brings to each scenario, such as reduced metadata overhead
>     and optimized startup times.
>
> 3.  Clarify tool descriptions: Standardized and improved the summaries
>     for mkfs.erofs, mount.erofs, erofsfuse, dump.erofs, and fsck.erofs
>     to ensure users understand the primary purpose of each utility in
>     the erofs-utils suite.
>
> 4.  Enhance technical instructional sections: Refined the "How to
>     generate" sections to be more instructional and professional.
>     Algorithm lists, command examples, and technical notes on
>     reproducibility and pcluster management have been rewritten for
>     improved clarity.
>
> 5.  Refine the "Comments" section: Clarified the description of
>     tail-packing to better explain its benefits regarding I/O
>     minimization and storage efficiency by eliminating internal
>     fragmentation in the last block of a file.
>
> 6.  General copy-editing: Fixed minor grammatical issues, improved
>     sentence structure, and ensured consistent capitalization and
>     terminology throughout the document.
>
> These changes collectively provide a more professional and informative
> first impression for new users while offering clearer technical context
> for developers working with EROFS. This documentation update ensures
> that the README remains an effective and high-quality introduction to
> the project's capabilities and tooling.
>
> Signed-off-by: Saksham <aghi.saksham5@gmail.com>
> ---
>  README | 298 +++++++++++++++++++++++++++------------------------------
>  1 file changed, 141 insertions(+), 157 deletions(-)
>
> diff --git a/README b/README
> index 6f9e761..d974305 100644
> --- a/README
> +++ b/README
> @@ -1,292 +1,276 @@
>  erofs-utils
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Userspace tools for EROFS filesystem, currently including:
> +Userspace tools for the EROFS filesystem, including:
>
> -  mkfs.erofs    filesystem formatter
> -  mount.erofs   mount helper for EROFS
> -  erofsfuse     FUSE daemon alternative
> -  dump.erofs    filesystem analyzer
> -  fsck.erofs    filesystem compatibility & consistency checker as well
> -                as extractor
> +  mkfs.erofs    Filesystem formatter
> +  mount.erofs   Mount helper for EROFS
> +  erofsfuse     FUSE-based EROFS implementation
> +  dump.erofs    Filesystem analyzer
> +  fsck.erofs    Filesystem consistency checker and extractor
>
>
> -EROFS filesystem overview
> +EROFS Filesystem Overview
>  -------------------------
>
> -EROFS filesystem stands for Enhanced Read-Only File System.  It aims to
> -form a generic read-only filesystem solution for various read-only use
> -cases instead of just focusing on storage space saving without
> -considering any side effects of runtime performance.
> +EROFS (Enhanced Read-Only File System) is designed to provide a high-per=
formance,
> +generic read-only filesystem solution for a wide variety of scenarios. U=
nlike
> +traditional read-only filesystems that often prioritize maximum storage =
savings
> +at the cost of significant runtime performance overhead, EROFS is engine=
ered to
> +balance efficient compression with superior data access speeds.
>
> -Typically EROFS could be considered in the following use scenarios:
> -  - Firmwares in performance-sensitive systems, such as system
> -    partitions of Android smartphones;
> +Typical EROFS use cases include:
>
> -  - Mountable immutable images such as container images for effective
> -    metadata & data access compared with tar, cpio or other local
> -    filesystems (e.g. ext4, XFS, btrfs, etc.)
> +  - Firmware for performance-critical systems, such as system partitions=
 in
> +    Android smartphones;
>
> -  - FSDAX-enabled rootfs for secure containers (Linux 5.15+);
> +  - Highly efficient, mountable immutable images (e.g., container images=
)
> +    offering optimized metadata and data access compared to tar, cpio, o=
r
> +    traditional local filesystems (such as ext4, XFS, and btrfs);
>
> -  - Live CDs which need a set of files with another high-performance
> -    algorithm to optimize startup time; others files for archival
> -    purposes only are not needed;
> +  - FSDAX-enabled rootfs for secure, high-performance containers (suppor=
ted
> +    since Linux 5.15);
>
> -  - and more.
> +  - Live CDs and bootable media requiring high-performance data retrieva=
l to
> +    minimize system startup times;
>
> -Note that all EROFS metadata is uncompressed by design, so that you
> -could take EROFS as a drop-in read-only replacement of ext4, XFS,
> -btrfs, etc. without any compression-based dependencies and EROFS can
> -bring more effective filesystem accesses to users with reduced
> -metadata.
> +  - Archival storage where fast random access to compressed data is requ=
ired.
>
> -For more details of EROFS filesystem itself, please refer to:
> +By design, all EROFS metadata remains uncompressed. This allows EROFS to=
 serve
> +as a high-performance, drop-in read-only replacement for filesystems lik=
e ext4,
> +XFS, or btrfs, even without compression-based dependencies. This archite=
ctural
> +choice ensures more effective filesystem access and reduced metadata ove=
rhead
> +for end users.
> +
> +For more details on the EROFS filesystem itself, please refer to the off=
icial
> +documentation:
>  https://www.kernel.org/doc/html/next/filesystems/erofs.html
>
> -For more details on how to build erofs-utils, see `docs/INSTALL.md`.
> +Detailed instructions for building erofs-utils are available in
> +`docs/INSTALL.md`.
>
> -For more details about filesystem performance, see
> +For a comprehensive analysis of filesystem performance, see
>  `docs/PERFORMANCE.md`.
>
>
>  mkfs.erofs
>  ----------
>
> -Two main kinds of EROFS images can be generated: (un)compressed images.
> +`mkfs.erofs` can generate two primary types of EROFS images: uncompresse=
d and
> +compressed.
>
> - - For uncompressed images, there will be no compressed files in these
> -   images.  However, an EROFS image can contain files which consist of
> -   various aligned data blocks and then a tail that is stored inline in
> -   order to compact images [1].
> + - **Uncompressed Images:** These images do not contain compressed file =
data.
> +   However, EROFS utilizes a technique where various aligned data blocks=
 are
> +   followed by an inlined tail to compact the image size effectively [1]=
.
>
> - - For compressed images, it will try to use the given algorithms first
> -   for each regular file and see if storage space can be saved with
> -   compression. If not, it will fall back to an uncompressed file.
> + - **Compressed Images:** The formatter attempts to compress each regula=
r file
> +   using the specified algorithms. If compression does not yield storage
> +   savings, the tool automatically falls back to an uncompressed format =
for
> +   that specific file.
>
> -Note that EROFS supports per-file compression configuration, proper
> -configuration options need to be enabled to parse compressed files by
> -the Linux kernel.
> +Note that EROFS supports per-file compression configurations. Ensure tha=
t the
> +target Linux kernel is configured with the necessary options to parse th=
e
> +selected compression formats.
>
>  How to generate EROFS images
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -Compression algorithms could be specified with the command-line option
> -`-z` to build a compressed EROFS image from a local directory:
> +Compression algorithms are specified using the `-z` command-line option.=
 For
> +example, to build a compressed EROFS image from a local directory using =
LZ4HC:
>   $ mkfs.erofs -zlz4hc foo.erofs.img foo/
>
> -Supported algorithms by the Linux kernel:
> +Supported algorithms in the Linux kernel:
>   - LZ4 (Linux 5.3+);
>   - LZMA (Linux 5.16+);
>   - DEFLATE (Linux 6.6+);
>   - Zstandard (Linux 6.10+).
>
> -Alternatively, generate an uncompressed EROFS from a local directory:
> +Alternatively, to generate an uncompressed EROFS image:
>   $ mkfs.erofs foo.erofs.img foo/
>
> -Additionally, you can specify a higher compression level to get a
> -(slightly) smaller image than the default level:
> +You can also specify a higher compression level to achieve a smaller ima=
ge
> +size (e.g., level 12 for LZ4HC):
>   $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
>
> -Multi-threaded support can be explicitly enabled with the ./configure
> -option `--enable-multithreading`; otherwise, single-threaded compression
> -will be used for now.  It may take more time on multiprocessor platforms
> -if multi-threaded support is not enabled.
> +Multi-threaded support can be enabled during the build process using the
> +`--enable-multithreading` configure option. If enabled, `mkfs.erofs` wil=
l
> +utilize multiple processors to accelerate the compression process.
>
> -Currently, `-Ededupe` doesn't support multi-threading due to limited
> -development resources.
> +Currently, the `-Ededupe` option does not support multi-threading.
>
>  Reproducible builds
>  ~~~~~~~~~~~~~~~~~~~
>
> -Reproducible builds are typically used for verification and security,
> -ensuring the same binaries/distributions to be reproduced in a
> -deterministic way.
> -
> -Images generated by the same version of `mkfs.erofs` will be identical
> -to previous runs if the same input is specified, and the same options
> -are used.
> +EROFS supports reproducible builds, which are essential for verification=
 and
> +security. This ensures that the same input and options always result in
> +bit-for-bit identical filesystem images.
>
> -Specifically, variable timestamps and filesystem UUIDs can result in
> -unreproducible EROFS images.  `-T` and `-U` can be used to fix them.
> +To ensure reproducibility, you may need to fix variable timestamps and
> +filesystem UUIDs using the `-T` and `-U` options, respectively.
>
>  How to generate EROFS big pcluster images (Linux 5.13+)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -By default, EROFS formatter compresses data into separate one-block
> -(e.g. 4KiB) filesystem physical clusters for outstanding random read
> -performance.  In other words, each EROFS filesystem block can be
> -independently decompressed.  However, other similar filesystems
> -typically compress data into "blocks" of 128KiB or more for much smaller
> -images.  Users may prefer smaller images for archiving purposes, even if
> -random performance is compromised with those configurations, and even
> -worse when using 4KiB blocks.
> -
> -In order to fulfill users' needs, big pclusters has been introduced
> -since Linux 5.13, in which each physical clusters will be more than one
> -blocks.
> -
> -Specifically, `-C` is used to specify the maximum size of each pcluster
> -in bytes:
> +By default, the EROFS formatter compresses data into separate one-block =
(e.g.,
> +4KiB) physical clusters (pclusters) to ensure exceptional random read
> +performance. This allows each block to be decompressed independently. In
> +contrast, other filesystems often use much larger compression blocks (12=
8KiB+),
> +which can improve compression ratios at the expense of random access lat=
ency.
> +
> +To accommodate different needs, "big pclusters" were introduced in Linux=
 5.13,
> +allowing physical clusters to span multiple blocks.
> +
> +The `-C` option specifies the maximum pcluster size in bytes:
>   $ mkfs.erofs -zlz4hc -C65536 foo.erofs.img foo/
>
> -Thus, in this case, pcluster sizes can be up to 64KiB.
> +In this example, pcluster sizes can reach up to 64KiB.
>
> -Note that large pcluster size can degrade random performance (though it
> -may improve sequential read performance for typical storage devices), so
> -please evaluate carefully in advance.  Alternatively, you can make
> -per-(sub)file compression strategies according to file access patterns
> -if needed.
> +Note: Larger pcluster sizes may improve sequential read performance on s=
ome
> +storage devices but can degrade random access performance. Evaluate your
> +workload requirements carefully. You can also apply per-file compression
> +strategies based on specific access patterns.
>
>  How to generate EROFS images with multiple algorithms
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -It's possible to generate an EROFS image with files in different
> -algorithms due to various purposes.  For example, LZMA for archival
> -purposes and LZ4 for runtime purposes.
> +EROFS allows mixing different compression algorithms within a single ima=
ge to
> +suit different needs=E2=80=94for instance, using LZMA for archival data =
and LZ4 for
> +frequently accessed runtime files.
>
> -In order to use alternative algorithms, just specify two or more
> -compressing configurations together separated by ':' like below:
> +To use multiple algorithms, specify them in the `-z` option separated by
> +colons:
>      -zlzma:lz4hc,12:lzma,9 -C32768
>
> -Although mkfs still choose the first one by default, you could try to
> -write a compress-hints file like below:
> +While the formatter defaults to the first algorithm, you can use a
> +compress-hints file to map specific files or directories to different
> +algorithms:
>      4096  1 .*\.so$
>      32768 2 .*\.txt$
>      4096    sbin/.*$
>      16384 0 .*
>
> -and specify with `--compress-hints=3D` so that ".so" files will use
> -"lz4hc,12" compression with 4k pclusters, ".txt" files will use
> -"lzma,9" compression with 32k pclusters, files  under "/sbin" will use
> -the default "lzma" compression with 4k pclusters and other files will
> -use "lzma" compression with 16k pclusters.
> +Specify the hints file with `--compress-hints=3D`. In this configuration=
, `.so`
> +files use `lz4hc,12` with 4KiB pclusters, `.txt` files use `lzma,9` with=
 32KiB
> +pclusters, and so on.
>
> -Note that the largest pcluster size should be specified with the "-C"
> -option (here 32k pcluster size), otherwise all larger pclusters will be
> -limited.
> +Note: The `-C` option must specify the largest pcluster size used in the
> +hints file to avoid limiting compression efficiency.
>
>  How to generate well-compressed EROFS images
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -Even if EROFS is not designed for such purposes in the beginning, it
> -could still produce some smaller images (not always) compared to other
> -approaches with better performance (see `docs/PERFORMANCE.md`).  In
> -order to build well-compressed EROFS images, try the following options:
> - -C1048576                     (5.13+)
> - -Eztailpacking                (5.16+)
> - -Efragments / -Eall-fragments ( 6.1+);
> - -Ededupe                      ( 6.1+).
> +While EROFS prioritizes performance, it can still achieve competitive
> +compression ratios. To maximize storage efficiency, consider the followi=
ng
> +options:
> + -C1048576                     (Large pclusters, Linux 5.13+)
> + -Eztailpacking                (Tail-packing for compressed files, Linux=
 5.16+)
> + -Efragments / -Eall-fragments (Fragment-based compression, Linux 6.1+)
> + -Ededupe                      (Global data deduplication, Linux 6.1+)
>
> -Also EROFS uses lz4hc level 9 by default, whereas some other approaches
> -use lz4hc level 12 by default.  So please explicitly specify
> -`-zlz4hc,12 ` for comparison purposes.
> +EROFS defaults to LZ4HC level 9. For maximum compression, specify level =
12:
> + `-zlz4hc,12`
>
>  How to generate legacy EROFS images (Linux 4.19+)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -Decompression inplace and compacted indexes have been introduced in
> -Linux v5.3, which are not forward-compatible with older kernels.
> -
> -In order to generate _legacy_ EROFS images for old kernels,
> -consider adding "-E legacy-compress" to the command line, e.g.
> +Features like in-place decompression and compacted indexes (introduced i=
n
> +Linux 5.3) are not compatible with older kernels. To generate images for
> +kernels between 4.19 and 5.3, use the legacy option:
>
>   $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
>
> -For Linux kernel >=3D 5.3, legacy EROFS images are _NOT recommended_
> -due to runtime performance loss compared with non-legacy images.
> +Note: Legacy images are not recommended for Linux kernel 5.3 and newer, =
as
> +they do not benefit from the performance optimizations available in mode=
rn
> +EROFS implementations.
>
>  Obsoleted erofs.mkfs
>  ~~~~~~~~~~~~~~~~~~~~
>
> -There is an original erofs.mkfs version developed by Li Guifu,
> -which was replaced by the new erofs-utils implementation.
> -
> +The original `erofs.mkfs` implementation by Li Guifu has been superseded=
 by
> +the current `erofs-utils`. The old version is available for historical
> +reference but is highly discouraged for production use:
>  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b o=
bsoleted_mkfs
>
> -PLEASE NOTE: This version is highly _NOT recommended_ now.
> -
>
>  mount.erofs
>  -----------
>
> -mount.erofs is a mount helper for EROFS filesystem, which can be used
> -to mount EROFS images with various backends including direct kernel
> -mount, FUSE-based mount, and NBD for remote sources like OCI images.
> +`mount.erofs` is a versatile mount helper that supports various backends=
,
> +including direct kernel mounts, FUSE-based mounts, and NBD for remote
> +sources like OCI images.
>
>  How to mount an EROFS image
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -To mount an EROFS image directly:
> +Direct kernel mount:
>   $ mount.erofs foo.erofs /mnt
>
> -To mount with FUSE backend:
> +FUSE-based mount:
>   $ mount.erofs -t erofs.fuse foo.erofs /mnt
>
> -To mount from OCI image with NBD backend:
> +NBD-based mount from an OCI image:
>   $ mount.erofs -t erofs.nbd -o oci.blob=3Dsha256:... <IMAGE>:<TAG> mnt
>
> -To unmount an EROFS filesystem:
> +Unmount:
>   $ mount.erofs -u mnt
>
> -For more details, see mount.erofs(8) manpage.
> +Refer to the `mount.erofs(8)` manpage for further details.
>
>
>  erofsfuse
>  ---------
>
> -erofsfuse is introduced to support EROFS format for various platforms
> -(including older linux kernels) and new on-disk features iteration.
> -It can also be used as an unpacking tool for unprivileged users.
> -
> -It supports fixed-sized output decompression *without* any in-place
> -I/O or in-place decompression optimization. Also like the other FUSE
> -implementations, it suffers from most common performance issues (e.g.
> -significant I/O overhead, double caching, etc.)
> +`erofsfuse` provides EROFS support for platforms without native kernel
> +drivers and serves as a tool for rapid feature iteration. It is also
> +useful for unprivileged users to unpack EROFS images.
>
> -Therefore, NEVER use it if performance is the top concern.
> +`erofsfuse` performs fixed-sized output decompression and does not inclu=
de
> +the in-place I/O or decompression optimizations found in the kernel driv=
er.
> +As with most FUSE implementations, it may experience higher I/O overhead
> +and double caching. It is not recommended for performance-critical
> +applications.
>
>  How to mount an EROFS image with erofsfuse
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -As the other FUSE implementations, it's quite easy to mount by using
> -erofsfuse, e.g.:
> +To mount an image:
>   $ erofsfuse foo.erofs.img foo/
>
> -Alternatively, to make it run in foreground (with debugging level 3):
> +To run in the foreground with debug logging (level 3):
>   $ erofsfuse -f --dbglevel=3D3 foo.erofs.img foo/
>
> -To debug erofsfuse (also automatically run in foreground):
> +To run in debug mode (automatically foreground):
>   $ erofsfuse -d foo.erofs.img foo/
>
> -To unmount an erofsfuse mountpoint as a non-root user:
> +To unmount as a non-root user:
>   $ fusermount -u foo/
>
>
>  dump.erofs and fsck.erofs
>  -------------------------
>
> -dump.erofs and fsck.erofs are used to analyze, check, and extract
> -EROFS filesystems. Note that extended attributes and ACLs are still
> -unsupported when extracting images with fsck.erofs.
> +`dump.erofs` and `fsck.erofs` are essential tools for analyzing, verifyi=
ng,
> +and extracting EROFS filesystems. Note that extended attributes (xattrs)=
 and
> +ACLs are currently not supported during extraction with `fsck.erofs`.
> +
> +Extraction in `fsck.erofs` is currently single-threaded. Contributions t=
o
> +optimize this process are welcome.
>
> -Note that extraction with fsck.erofs is still single-threaded and will
> -need optimization later.  If you are interested, contributions are, as
> -always, welcome.
>
>  Contribution
>  ------------
>
> -erofs-utils is a part of EROFS filesystem project, which is completely
> -community-driven open source software.  If you have interest in EROFS,
> -feel free to send feedback and/or patches to:
> +EROFS-utils is a key component of the EROFS filesystem project and is
> +entirely community-driven. We welcome feedback, bug reports, and patches=
.
> +
> +Please send your contributions to the mailing list:
>    linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
>
>
>  Comments
>  --------
>
> -[1] According to the EROFS on-disk format, the tail blocks of files
> -    could be inlined aggressively with their metadata (called
> -    tail-packing) in order to minimize the extra I/Os and the storage
> -    space.
> +[1] EROFS on-disk format allows the tail blocks of files to be inlined
> +    with their metadata (tail-packing). This reduces extra I/O operation=
s
> +    and saves storage space by eliminating internal fragmentation in the
> +    last block of a file.
> --
> 2.53.0
>
>

