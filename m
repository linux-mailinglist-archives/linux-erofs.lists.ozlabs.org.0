Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D459974B70A
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jul 2023 21:23:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tgLCFacD;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QyNbS4Plkz3c24
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 05:23:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tgLCFacD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QyNbL1hkfz3bwd
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 05:23:10 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B601A61A34;
	Fri,  7 Jul 2023 19:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63501C433C7;
	Fri,  7 Jul 2023 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688757785;
	bh=94A738552oPcNLUcdadUB8TIEGBu7Z7b4zP4i/CSZhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgLCFacDRH2vFBvGsS1BdApLvk5sLS7WaSV2sgoXnSapnBONfvmv9X8eKnvugMJHE
	 jqjgRwSKqOqTX8fmIldEGKg0KhXTvE0Bema9AGOztxJ3On1k5IAODVtjRLYQSXxP2D
	 t/ZQ+Qpmi+iWBisfwT5UB4sgtSMbE1mZirUi9Sv4DwscQ0HrO92bVw63QK67r9cxrQ
	 QxbM6U35zant3vdXmjw3fsF5Ss+czDaGBBWJvUTejeoPPj3ruozwzQAv9CaKvhOlKV
	 2nM3B31uev1RK+ZATSoyzNzgygragekkgVMBHp/70Fr46Mi/QGbs3iEtE2igexxk6o
	 AYNbqLhudXizg==
From: SeongJae Park <sj@kernel.org>
To: David Wysochanski <dwysocha@redhat.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in shrink_folio_list+0x9f4/0x1ae0
Date: Fri,  7 Jul 2023 19:23:01 +0000
Message-Id: <20230707192301.27308-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-afs@lists.infradead.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, SeongJae Park <sj@kernel.org>, Rohith Surabattula <rohiths.msft@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, Daire Byrne <daire.byrne@gmail.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 7 Jul 2023 14:12:06 -0400 David Wysochanski <dwysocha@redhat.com> wrote:

> On Fri, Jul 7, 2023 at 12:46 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Sat, Jul 8, 2023 at 1:39 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 11:48:52AM +0100, David Howells wrote:
> > > > Fscache has an optimisation by which reads from the cache are skipped until
> > > > we know that (a) there's data there to be read and (b) that data isn't
> > > > entirely covered by pages resident in the netfs pagecache.  This is done
> > > > with two flags manipulated by fscache_note_page_release():
> > > >
> > > >       if (...
> > > >           test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> > > >           test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> > > >               clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> > > >
> > > > where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to indicate
> > > > that netfslib should download from the server or clear the page instead.
> > > >
> > > > The fscache_note_page_release() function is intended to be called from
> > > > ->releasepage() - but that only gets called if PG_private or PG_private_2
> > > > is set - and currently the former is at the discretion of the network
> > > > filesystem and the latter is only set whilst a page is being written to the
> > > > cache, so sometimes we miss clearing the optimisation.
> > > >
> > > > Fix this by following Willy's suggestion[1] and adding an address_space
> > > > flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always call
> > > > ->release_folio() if it's set, even if PG_private or PG_private_2 aren't
> > > > set.
> > > >
> > > > Note that this would require folio_test_private() and page_has_private() to
> > > > become more complicated.  To avoid that, in the places[*] where these are
> > > > used to conditionalise calls to filemap_release_folio() and
> > > > try_to_release_page(), the tests are removed the those functions just
> > > > jumped to unconditionally and the test is performed there.
> > > >
> > > > [*] There are some exceptions in vmscan.c where the check guards more than
> > > > just a call to the releaser.  I've added a function, folio_needs_release()
> > > > to wrap all the checks for that.
> > > >
> > > > AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
> > > > fscache and cleared in ->evict_inode() before truncate_inode_pages_final()
> > > > is called.
> > > >
> > > > Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cleared
> > > > and the optimisation cancelled if a cachefiles object already contains data
> > > > when we open it.
> > > >
> > > > Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release of a page")
> > > > Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> > > > Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > >
> > > Hi David,
> > >
> > > I was bisecting a use-after-free BUG on the latest mm-unstable,
> > > where HEAD is 347e208de0e4 ("rmap: pass the folio to __page_check_anon_rmap()").
> > >
> > > According to my bisection, this is the first bad commit.
> > > Use-After-Free is triggered on reclamation path when swap is enabled.
> >
> > This was originally occurred during kernel compilation but
> > can easily be reproduced via:
> >
> > stress-ng --bigheap $(nproc)
> >
> > > (and couldn't trigger without swap enabled)
> > >
> > > the config, KASAN splat, bisect log are attached.
> > > hope this isn't too late :(
> > >
> > > > cc: Matthew Wilcox <willy@infradead.org>
> > > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > cc: Steve French <sfrench@samba.org>
> > > > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > > > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > > > cc: Dave Wysochanski <dwysocha@redhat.com>
> > > > cc: Dominique Martinet <asmadeus@codewreck.org>
> > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > cc: linux-cachefs@redhat.com
> > > > cc: linux-cifs@vger.kernel.org
> > > > cc: linux-afs@lists.infradead.org
> > > > cc: v9fs-developer@lists.sourceforge.net
> > > > cc: ceph-devel@vger.kernel.org
> > > > cc: linux-nfs@vger.kernel.org
> > > > cc: linux-fsdevel@vger.kernel.org
> > > > cc: linux-mm@kvack.org
> > > > ---
> > > >
> > > > Notes:
> > > >     ver #7)
> > > >      - Make NFS set AS_RELEASE_ALWAYS.
> > > >
> > > >     ver #4)
> > > >      - Split out merging of folio_has_private()/filemap_release_folio() call
> > > >        pairs into a preceding patch.
> > > >      - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> > > >
> > > >     ver #3)
> > > >      - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
> > > >      - Moved a '&&' to the correct line.
> > > >
> > > >     ver #2)
> > > >      - Rewrote entirely according to Willy's suggestion[1].
> > > >
> > > >  fs/9p/cache.c           |  2 ++
> > > >  fs/afs/internal.h       |  2 ++
> > > >  fs/cachefiles/namei.c   |  2 ++
> > > >  fs/ceph/cache.c         |  2 ++
> > > >  fs/nfs/fscache.c        |  3 +++
> > > >  fs/smb/client/fscache.c |  2 ++
> > > >  include/linux/pagemap.h | 16 ++++++++++++++++
> > > >  mm/internal.h           |  5 ++++-
> > > >  8 files changed, 33 insertions(+), 1 deletion(-)
> 
> 
> I think myself / Daire Byrne may have already tracked this down and I
> found a 1-liner that fixed a similar crash in his environment.
> 
> Can you try this patch on top and let me know if it still crashes?
> https://github.com/DaveWysochanskiRH/kernel/commit/902c990e311120179fa5de99d68364b2947b79ec

I also encountered this issue with my DAMON tests, and was trying to find a
time slot for deep dive.  And I confirmed your fix works.  Thank you for this
great work.  Please Cc me when you post the patch if possible.

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> 
