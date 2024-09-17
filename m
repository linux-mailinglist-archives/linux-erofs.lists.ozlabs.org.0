Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7397B5B2
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 00:22:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7brB5cB0z2yGX
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 08:22:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726611747;
	cv=none; b=l7o795XKsCrbmA0eCPmd9Ej9XXOV+BkTTWaSsQlo5iE+36jzJLa5lohq53e+Bl5lqJ+T4TCLHfK++koHWOpG0QA+maKrO8Am50+CEjzDTZoJL/s7YUh91ghHeP43GZF1WyVGBp8lPiJVlczEgXSfsZtC/4rgZPRpEoPtvFQOkyQ7NcgG13tkRWjKhjJeAdgtpUQRKMlaifv4DAQM9E7UsfExy1IS/TbRobzS1IPLz7ryo6OmAzWxAGvYVlkICwrDh3EaC8COWh5df5QApBY1wE5MuRribJEgJ4FMH420ywaFf0WZhZ0v1ewSL6DgtFb5wUaeYEpg6g5E2PJ4b8MqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726611747; c=relaxed/relaxed;
	bh=iLQ5LiZffWjY0HKID2pJokQ+7vMW0GhlCO+qySBS8dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM8qv3/paTAUcjXMv3J+vnYynEWvS0wY+Cm5x/3YHYsAOzErWisP5BukLP9v4E2G5uHStRlo5E/Q6PZEySE+rrnRoZscHXo8eTvA+mv9UdIqW8R2IhgUBSMQRrWfxr2Tr5BIb7p5Yv1KssvYtu2gKADJUdi7RDBC5jJhhJ7h3uaq5KZCXeQ8Jmcoa3kn9FK5oPlEpbC7h8gzUSYHDAgQbDQF/R35I6BkBjQp2S0GqGZJmenKmx6InFeHM5WaVyv8Heb7Mm0Oz3hgWW7xoLCy2Ca2e12m6EsXeq1zUY40JfXuJpLSL58UKZoIDWaTFOGo3rxoKTtNvqj+LBNtza55eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=bkVOdYuO; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=bkVOdYuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7br20Z1Dz2xJy
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Sep 2024 08:22:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iLQ5LiZffWjY0HKID2pJokQ+7vMW0GhlCO+qySBS8dA=; b=bkVOdYuOwPg80KgLMJGdoYMcRG
	wLzPnAAj9GE+DC3QXzU/yJ9lkHW1WbPFoJx94t8fLUD3RgkS4jzLyj3bvrroQuTlXCgy74FhjD8fV
	YgvTPj7HvivM9mzttpf3hy2A7AsUWcDBQ9E3bOThKoWGb6oAPPk5A+DzJ9IHeupSOV/kHZuo5Qpfb
	XbL3m1JHwhb76Qq6bwgJoZJ4Uk1ukQSvULg9QUhuAwFQso20pZXd7S36tDPUD9zQMH/WtGDAn44Rj
	iL6FAd0w++VJvRtz1/gP/AaU9ObAY0CMkDw8MsKjMNNKDYQIbS7wA6XxD39vI9/nrIVdcLykek4y+
	VGsEdF/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqgaM-0000000DGfH-3tnr;
	Tue, 17 Sep 2024 22:22:14 +0000
Date: Tue, 17 Sep 2024 23:22:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240917222214.GF3107530@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV>
 <20240917074429.GE3107530@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917074429.GE3107530@ZenIV>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 17, 2024 at 08:44:29AM +0100, Al Viro wrote:

> Anyway, I'm half-asleep at the moment and I'd rather leave writing these
> rules up until tomorrow.  Sorry...


[Below are the bits of my notes related to d_name and d_parent,
with most of the unprintable parts thrown out and minimal markup added.
Probably not all relevant notes are here - this has been culled from
a bunch of files sitting around and I might've missed some]

NOTE: ->d_parent and ->d_name are by far the worst parts of dentry
wrt stability rules.  Code audits are not pleasant, to put it mildly.
This covers the bits outside of VFS proper - verifying the locking
rules is a separate story.


A Really Blunt Tool You Should Not Use.
======================================

All changes of ->d_parent are serialized on rename_lock.  It's *NOT*
something you want the stuff outside of core VFS to touch, though.
It's a seqlock, and write_seqlock() on it is limited to fs/dcache.c
alone.  Reader side is allowed, but it's still not something you
want to use lightly - outside of fs/dcache.c, fs/d_path.c and fs/namei.c
there are only 3 users (ceph_mdsc_build_path(), nfs_path() and
auditsc handle_path()).  Don't add more without a discussion on fsdevel
and detailed ACKs; it's quite likely that a better solution will be
found.

With one exception (see the discussion of d_mark_tmpfile() in the end),
->d_name is also stabilized by that.


Slightly Less Blunt Tool You Still Should Not Use.
==================================================

->s_vfs_rename_mutex will stabilize ->d_parent.  The trouble is,
while it's not system-wide like rename_lock, it's fs-wide, so there's
a plenty of contention to run into *AND* if you try that while
->i_rwsem is held on some directory in that filesystem, you are fucked -
lock_rename() (and rename(2), and...) will deadlock on you.
Nothing outside of fs/{namei,dcache}.c touches it directly; there is
an indirect use (lock_rename()), but that should be done only around
the call of cross-directory rename on _another_ filesystem - overlayfs
moving stuff within the writable layer, ecryptfs doing rename on
underlying filesystem, nfsd handling rename request from client, etc.

Anyone trying to use that hammer without a good reason will be very
sorry - that's a promise.  The pain will begin with the request to
adjust the proof of deadlock avoidance in directory locking and it
will only go downwards from there...


Parent's ->i_rwsem Held Exclusive.
==================================

That stabilizes ->d_parent and ->d_name.  To be more precise,

holding parent->d_inode->i_rwsem exclusive stabilizes the result
of (dentry->d_parent == parent).  That is to say, dentry
that is a child of parent will remain such and dentry that isn't
a child won't become a child.

holding parent->d_inode->i_rwsem exclusive stabilizes ->d_name of
all children.  In other words, if you've locked the parent exclusive
and found something to be its child while keeping the parent locked,
child will have ->d_parent and ->d_name stable until you unlock the
parent.

That covers most of the directory-modifying methods - stuff like
->mkdir(), ->unlink(), ->rename(), etc. can access ->d_parent and
->d_name of the dentry argument(s) without any extra locks; the
caller is already holding enough.  Well, unless you are special
(*cough* apparmor *cough*) and feel like dropping and regaining
the lock on parent inside your ->mkdir()...  Don't do that, please -
you might have no renames, but there's a plenty of other headache
you can get into that way.


Negatives.
==========

Negative dentry doesn't change ->d_parent or ->d_name.  Of course,
that is only worth something if you are guaranteed that it won't
become positive under you - if that happens, all bets are off.

Holding the inode of parent locked (at least) shared is enough to
guarantee that.  That takes care of ->lookup() instances - their
dentry argument has ->d_parent and ->d_name stable until you make
it positive (normally - by d_splice_alias()).  Once you've done
d_splice_alias(), you'd better be careful with access to those;
you won't get hit by concurrent rename() (it locks parent(s)
exclusive), but if your inode is a directory and d_splice_alias()
*elsewhere* picks the same inode (fs image corruption, network
filesystem with rename done from another client behind your back,
etc.), you'll see the sucker moved.

In practice, d_splice_alias() is the last thing done by most of ->lookup()
instances - whatever it has returned gets returned by ->lookup() itself,
possibly after freeing some temporary allocations, etc.  The rest needs
to watch out for accesses to ->d_name and ->d_parent downstream of
d_splice_alias() return.

Another case where we are guaranteed that dentry is negative and
will stay so is ->d_release() - it's called for a dentry that is
well on the way to becoming an ex-parrot; it's already marked
dead, unhashed and negative.  So a ->d_release() instance doesn't
have to worry about ->d_name and ->d_parent - both are valid and
stable.


sprintf().
==========

%pd prints dentry name, safely.  %p2d - parent_name/dentry_name, etc. up
to %p4d.  %pD .. %p4D  do the same by file reference.  Any time you see
pr_warn("Some weird bollocks with %s (%d)\n", dentry->d_name, err);
it should've been
pr_warn("Some weird bollocks with %pd (%d)\n", dentry, err)...

d_path() and friends are there for purpose - don't open-code those without
a damn good reason.


Checking if one dentry is an ancestor of another.
=================================================

Use the damn is_subdir(), don't open-code it.


Spinlocks.
==========

dentry->d_lock stabilizes ->d_parent and ->d_name (as well as almost
everything else about dentry); downside is that it's a spinlock
*and* nesting it is not to be attempted easily; you are allowed
to lock child while holding lock on parent, but very few places
have any business doing that (only 2 outside of VFS - tree-walking
in autofs, which might eventually get redone avoiding that and
fsnotify_set_children_dentry_flags(), which just might get moved to
fs/dcache.c itself; we'll see)

Note that "almost everything" includes refcount; that is to say, dget()
and dput() will spin if you are holding ->d_lock, so you can't dget()
the parent under ->d_lock on child - that's a locking order violation
that can easily deadlock on you.  dget_parent() does that kind of thing
safely, and a look at it might be instructive.  Try to open-code something
of that sort, and you'll be hurt.

Said that, dget_parent() is overused - it has legitimate uses, but
more often than not it's the wrong tool.  In particular, while you
grab a reference to something that was the parent at some point during
dget_parent(), it might not be the parent anymore by the time it is
returned to caller.

Most of the dget_parent() uses are due to bad calling conventions of
->d_revalidate().  When that gets sanitized, those will be gone.

The methods that are called with ->d_lock get the protection - that
would be ->d_delete() and ->d_prune().

->d_lock on parent is also sufficient; similar to exclusive ->i_rwsem,
parent->d_lock stabilizes (dentry->d_parent == parent) and if child
has been observed to have child->d_parent equal to parent after
you've locked parent->d_lock, you know that child->d_{parent,name}
will remain stable until you unlock the parent.


Name Snapshots.
===============

There's take_dentry_name_snapshot()/release_dentry_name_snapshot().
That stuff eats about 64 bytes on stack (longer names _are_ handled
correctly; no allocations are needed, we can simply grab an extra
reference to external name and hold it).  Can't be done under
->d_lock, won't do anything about ->d_parent *and* there's nothing
to prevent dentry being renamed while you are looking at the name
snapshot.  Sometimes it's useful...


RCU Headaches.
==============

See e.g. https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=fixes.pathwalk-rcu-2&id=8d0a75eba81813cbb00beb73a67783e1cde9982f
(NB: ought to repost that)


[*] d_mark_tmpfile() is pretty much a delayed bit of constructor.  There is
a possible intermediate state of dentry ("will be tmpfile one"); dentries
in that state are all created in vfs_tmpfile(), get passed to ->tmpfile()
where they transition to normal unhashed postive dentries.  The reason why
name is not set from the very beginning is that at that point we do not know
the inumber of inode they are going to get (that becomes known inside
->tmpfile() instance) and we want that inumber seen in their names (for
/proc/*/fd/*, basically).  Name change is done while holding ->d_lock both
on dentry itself and on its parent.
