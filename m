Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DB8963859
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 04:48:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvQgn0jtxz2ysD
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 12:48:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724899683;
	cv=none; b=Iu6K1414lAt0KHmNKnCSqLF5UMWF27xu2XpCwTcrlHjxBhutQCg3UATjsytATelv2iAxbHWH9F+k7xSikQ4CQdg8yPqCLJ73VvQ1NLIGbAVq20xXbRCJdm2AsYkYk7b1pV/d4BNqMjYFoCMcqTF0Idcv7RG2jV61s0MznMO9irhcbbWd+lUMm8STFYvP7XjK32snyhuxsK8vB4JTuBHb8MdnE+h/9kXKvVbAiEq4XnMbFpiLtDKVAQJl4/mondp/n5e7vxsnxQXuvQD3MlPOijMGl5criZHbygKTPufHz4NtwrjtpeCMhaHe0Z5c4urrhdTqhy6OpZlrNxN7n3RrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724899683; c=relaxed/relaxed;
	bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Google-Smtp-Source:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=kSVdfMmahZ5GyFDKYfaUjarfqQq+qz+fbX/dbhwqmE9HyqXFCoDILJBof3hhk+5y+3LHjj8M6HFsQg4qipL+jdmQTuf7jhev/Q5p7Mug7bszrqiaWmmmBI+MRGlugyqgbL0nW8LBD33mLU+8/L34kyVSLj61/W2FF+PcVfH7JIlVI8b3SwaR4YUFHj3Mzj32LJjBpyUKAUS9dgtEOWw9ZSjsfcjnIa7w2iesT8rt5cy56FZapt7NkcIb1p33OsSGYIfzoC6llUyfEWh9AUH9A9eK3goFQ2djHZsVUXxIjCFL76CLtzJ25d7OPgMz10twsBCLatL7ZEFMlmAUMwDIXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mbzZbaGl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mbzZbaGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvQgk1x8vz2ymb
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 12:48:00 +1000 (AEST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2f50966c448so1365931fa.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724899676; x=1725504476; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=mbzZbaGl399OpVU1tmFhBLK5f5SnVwrd7uV4xxqgVjRqSZaUF3m7vxaHE6ikidg1m7
         sOj3zBqBPGZ5amYWupPFtwOJ8zbHZp6y33i19A8amn6Habxta6A6UfasuyzGaEr4JHPY
         BGy9yUGL+b/3EWKwdYCoRQr3Z+dE9uD/fB3pCCONWlB0dNvmkWe9l+fqscU0HzkFNlGy
         bSVippgsq/7DMpsYSeTa2AfOZmxRjzwCFUVRJ2IdYSgO20ANr3XAUEy3Ks/2hmvw2Pio
         c2DY26ROQ7EHOziOegCs+O9RXrOmv/Bq5Sr24/10KNzVz9b6BwWLALRm/TV+fi2Qen5k
         h3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899676; x=1725504476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=E07hIbZgnnZ07HWXnFtb38eLle6AB5RCDCEr3wC4J9pYJ41e/2l9ZdGVOEZsWrv5ui
         /4lQFuOd6Y/g2B/ITbNU1PYrE7FfUTIRTYVatzpo4osMiapowEPF5Vihfo7R8GbX5pV1
         duxSOBzMjWxsCStr6w4GkgggQGfvhYZ//YC0W8L0Y1osggaQN+VNF7XDKdK+ONY1qUUA
         vtuTIy8jtfXYZVVqts9Kdo9mBWhvfkjDiTw208hBl/C7GXT+PJwWMaBIQluSicgaDR4E
         PEsA0dgXftAT9P3b03RLtKyv4qKLxjZGPs+Xra6sitJD5uRRCCYmkHS+PHs6SjCmpfLV
         0m/A==
X-Forwarded-Encrypted: i=1; AJvYcCX0N7X8jtmhExhzTjmibP2A0jgQkHLjm2mbpjOYlZ9fMHtKwqPPp0RULWajCujJ1o8ZnbqLmWL5pqg8/g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAMgUL4iZH/GoTWjaffLssX+tYry03zpgaI7TGN2LrpyL+4DFh
	Bgl3uudQMJYxe1htXVMLgRuZ74xvvq14tQ+Q9FftHn8CAWG3ZTid/ad8BVqPUs0ivw/473dvzcG
	mdhbgB8ax44JC2Dq7ijS8u/kDAD8=
X-Google-Smtp-Source: AGHT+IFw6YFPE4uQg6imkFHXMbxtDADWvwTRJd5bZLVgOFxAE0atjLaGwN/Y3Vs2U2TCttK/XyhsIPdmUPLmGEsItEg=
X-Received: by 2002:a05:6512:1055:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5353e5aae01mr710771e87.42.1724899675197; Wed, 28 Aug 2024
 19:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 28 Aug 2024 21:47:43 -0500
Message-ID: <CAH2r5muvO8+Es4Y8d=VtWEp-vcC62TYEZc3W1Y0r+6ro6d9yxQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm, netfs, cifs: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

testing is going fine so far with David's series ontop of current mainline

(I see one possible intermittent server bug failure - on test
generic/728 - but no red flags testing so far)

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/207

On Wed, Aug 28, 2024 at 4:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Christian, Steve,
>
> Firstly, here are some fixes to DIO read handling and the retrying of
> reads, particularly in relation to cifs:
>
>  (1) Fix the missing credit renegotiation in cifs on the retrying of read=
s.
>      The credits we had ended with the original read (or the last retry)
>      and to perform a new read we need more credits otherwise the server
>      can reject our read with EINVAL.
>
>  (2) Fix the handling of short DIO reads to avoid ENODATA when the read
>      retry tries to access a portion of the file after the EOF.
>
> Secondly, some patches fixing cifs copy and zero offload:
>
>  (3) Fix cifs_file_copychunk_range() to not try to partially invalidate
>      folios that are only partly covered by the range, but rather flush
>      them back and invalidate them.
>
>  (4) Fix filemap_invalidate_inode() to use the correct invalidation
>      function so that it doesn't leave partially invalidated folios hangi=
ng
>      around (which may hide part of the result of an offloaded copy).
>
>  (5) Fix smb3_zero_data() to correctly handle zeroing of data that's
>      buffered locally but not yet written back and with the EOF position =
on
>      the server short of the local EOF position.
>
>      Note that this will also affect afs and 9p, particularly with regard
>      to direct I/O writes.
>
> And finally, here's an adjustment to debugging statements:
>
>  (6) Adjust three debugging output statements.  Not strictly a fix, so
>      could be dropped.  Including the subreq ID in some extra debug lines
>      helps a bit, though.
>
> The patches can also be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-fixes
>
> Thanks,
> David
>
> David Howells (6):
>   cifs: Fix lack of credit renegotiation on read retry
>   netfs, cifs: Fix handling of short DIO read
>   cifs: Fix copy offload to flush destination region
>   mm: Fix filemap_invalidate_inode() to use
>     invalidate_inode_pages2_range()
>   cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target
>     region
>   netfs, cifs: Improve some debugging bits
>
>  fs/netfs/io.c            | 21 +++++++++++++-------
>  fs/smb/client/cifsfs.c   | 21 ++++----------------
>  fs/smb/client/cifsglob.h |  1 +
>  fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++++----
>  fs/smb/client/smb2ops.c  | 26 +++++++++++++++++++------
>  fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++++++++---------------
>  fs/smb/client/trace.h    |  1 +
>  include/linux/netfs.h    |  1 +
>  mm/filemap.c             |  2 +-
>  9 files changed, 101 insertions(+), 50 deletions(-)
>
>


--=20
Thanks,

Steve
