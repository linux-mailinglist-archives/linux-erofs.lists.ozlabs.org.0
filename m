Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485B74B53D
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jul 2023 18:47:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rdIoGdwP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QyK762VDRz3byT
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 02:46:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rdIoGdwP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=42.hyeyoo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QyK7108KLz3bpk
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 02:46:50 +1000 (AEST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-47e3f56ec02so845154e0c.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 07 Jul 2023 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688748405; x=1691340405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/ReIviycKOpXSvVBgcqd1EotrbzaoMQKO3qVU7I/G8=;
        b=rdIoGdwP5Ghffl0SSNU+UexYiw7dQQTY/KbUSpraUXheaqWYQIzf9VS2G54zkxoXeK
         Zs8WYI2qt4N0BqTuDA21gVijWUiGiy3OrYR8lv3DKyrgrFEFY/VwOEHPHcniApVN32A0
         PyNQdCHlm8WB6hLN7Grylpw6RdoDNjUV6Py9A1+F4jya88T8Iq9Ka7vxdq5yT5c1LaGv
         mhT4LjqqufdVQx6CIlQHGhtHR9EIUodVt14QLVcTA2E3j7ZHuNoD2AWGoyZkb9l6fTKO
         8M1Q1mr7rQzV9JK8pww9IzJ4dCo0vnfyDZPwzvga/a4qwpdfyRbTwoQs0RfSeuNrnbjJ
         agjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748405; x=1691340405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/ReIviycKOpXSvVBgcqd1EotrbzaoMQKO3qVU7I/G8=;
        b=FOgk9k25+LSP2Kjdrhku4phGwsMulszjsmgH4WRunrXyxwQnBCaV4cq+BQYNhl0G5h
         WrFNjZCFD4d+yJRQSoNFsFUEQmNWo3OZk/2ZkQ4NJEfgWZtvWSjzsu8JIl0KBye1mQRh
         CJgkrKGLX7/p2kyTcD1EnDzn9N/asecU1JQqqUSEIi0b41FJ0MHpk3apfcpTcgUKJ5Zu
         sU0qmnrm62JWc411Q3Kd9OP00tRC4eeSlqXa7h+lZX2WeCDeUGWJjo5HojbGvgae3E5b
         1iseow9yFLmb9GOLPiH631GUScTqWopQ1qqwIVu/yIFJGxPeet4FiTKQqYeoU1MGq/k4
         w5bA==
X-Gm-Message-State: ABy/qLZQr0MpYUmwh6Q2aknB/FlJc5fssIQWatBceOUy0uOnFxlExg0S
	FFyO/Kr5Uy/wgcdnznQCQJPjFR285lkPj5vuwMI=
X-Google-Smtp-Source: APBJJlGKmNTgweK2kwJWs4/wFqNBmjg4Djz4jCj6ZqMtOK2vtD8XozEN8rFv3LAaQCX0JTqMTCJbsPKbO24byO+QNwg=
X-Received: by 2002:a1f:43c4:0:b0:47e:91fc:d2b8 with SMTP id
 q187-20020a1f43c4000000b0047e91fcd2b8mr3487027vka.2.1688748404847; Fri, 07
 Jul 2023 09:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230628104852.3391651-1-dhowells@redhat.com> <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
In-Reply-To: <ZKg/J3OG3kQ9ynSO@fedora>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 8 Jul 2023 01:46:33 +0900
Message-ID: <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in shrink_folio_list+0x9f4/0x1ae0
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, linux-mm@kvack.org, Rohith Surabattula <rohiths.msft@gmail.com>, linux-erofs@lists.ozlabs.org, Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Steve French <sfrench@samba.org>, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 8, 2023 at 1:39=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com> =
wrote:
>
> On Wed, Jun 28, 2023 at 11:48:52AM +0100, David Howells wrote:
> > Fscache has an optimisation by which reads from the cache are skipped u=
ntil
> > we know that (a) there's data there to be read and (b) that data isn't
> > entirely covered by pages resident in the netfs pagecache.  This is don=
e
> > with two flags manipulated by fscache_note_page_release():
> >
> >       if (...
> >           test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> >           test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> >               clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)=
;
> >
> > where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to indi=
cate
> > that netfslib should download from the server or clear the page instead=
.
> >
> > The fscache_note_page_release() function is intended to be called from
> > ->releasepage() - but that only gets called if PG_private or PG_private=
_2
> > is set - and currently the former is at the discretion of the network
> > filesystem and the latter is only set whilst a page is being written to=
 the
> > cache, so sometimes we miss clearing the optimisation.
> >
> > Fix this by following Willy's suggestion[1] and adding an address_space
> > flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always =
call
> > ->release_folio() if it's set, even if PG_private or PG_private_2 aren'=
t
> > set.
> >
> > Note that this would require folio_test_private() and page_has_private(=
) to
> > become more complicated.  To avoid that, in the places[*] where these a=
re
> > used to conditionalise calls to filemap_release_folio() and
> > try_to_release_page(), the tests are removed the those functions just
> > jumped to unconditionally and the test is performed there.
> >
> > [*] There are some exceptions in vmscan.c where the check guards more t=
han
> > just a call to the releaser.  I've added a function, folio_needs_releas=
e()
> > to wrap all the checks for that.
> >
> > AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
> > fscache and cleared in ->evict_inode() before truncate_inode_pages_fina=
l()
> > is called.
> >
> > Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be clear=
ed
> > and the optimisation cancelled if a cachefiles object already contains =
data
> > when we open it.
> >
> > Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release o=
f a page")
> > Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> > Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: David Howells <dhowells@redhat.com>
>
> Hi David,
>
> I was bisecting a use-after-free BUG on the latest mm-unstable,
> where HEAD is 347e208de0e4 ("rmap: pass the folio to __page_check_anon_rm=
ap()").
>
> According to my bisection, this is the first bad commit.
> Use-After-Free is triggered on reclamation path when swap is enabled.

This was originally occurred during kernel compilation but
can easily be reproduced via:

stress-ng --bigheap $(nproc)

> (and couldn't trigger without swap enabled)
>
> the config, KASAN splat, bisect log are attached.
> hope this isn't too late :(
>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > cc: Steve French <sfrench@samba.org>
> > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Dave Wysochanski <dwysocha@redhat.com>
> > cc: Dominique Martinet <asmadeus@codewreck.org>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: linux-cachefs@redhat.com
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-afs@lists.infradead.org
> > cc: v9fs-developer@lists.sourceforge.net
> > cc: ceph-devel@vger.kernel.org
> > cc: linux-nfs@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > cc: linux-mm@kvack.org
> > ---
> >
> > Notes:
> >     ver #7)
> >      - Make NFS set AS_RELEASE_ALWAYS.
> >
> >     ver #4)
> >      - Split out merging of folio_has_private()/filemap_release_folio()=
 call
> >        pairs into a preceding patch.
> >      - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> >
> >     ver #3)
> >      - Fixed mapping_clear_release_always() to use clear_bit() not set_=
bit().
> >      - Moved a '&&' to the correct line.
> >
> >     ver #2)
> >      - Rewrote entirely according to Willy's suggestion[1].
> >
> >  fs/9p/cache.c           |  2 ++
> >  fs/afs/internal.h       |  2 ++
> >  fs/cachefiles/namei.c   |  2 ++
> >  fs/ceph/cache.c         |  2 ++
> >  fs/nfs/fscache.c        |  3 +++
> >  fs/smb/client/fscache.c |  2 ++
> >  include/linux/pagemap.h | 16 ++++++++++++++++
> >  mm/internal.h           |  5 ++++-
> >  8 files changed, 33 insertions(+), 1 deletion(-)
